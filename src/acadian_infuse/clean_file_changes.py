import src.utils as u
import toml
import os
import pandas as pd

def main():
  this_dir = os.path.dirname(os.path.realpath(__file__))
  config = toml.load(os.path.join(this_dir, 'config.toml'))

  u.set_full_paths(config, this_dir)
  df: pd.DataFrame = pd.read_csv(config['file_locations']['file_changes_raw'])  # type: ignore

  for col in ['lines_added', 'lines_deleted']:
    df = df[df[col] != '-']
    df[col] = pd.to_numeric(df[col], errors='coerce')

  df.convert_dtypes()

  # sum up all line adds and deletes per author per file
  summed_gdf = df.groupby(['author', 'file_name']).agg('sum')
  summed_df: pd.DataFrame = summed_gdf.unstack().unstack().reset_index()  # type: ignore
  summed_df.rename(columns={'level_0': 'line_action', 0: 'line_count'}, inplace=True)
  # if an author didnt contribute to a file, then dont show an entry for them on that file

  summed_df['line_count'] = summed_df['line_count'].astype('str')
  # la_df = summed_df.groupby(['author', 'file_name'])['line_action'].apply(';'.join).reset_index()
  lc_df: pd.DataFrame = summed_df.groupby(['author', 'file_name'])[
      'line_count'].apply(';'.join).reset_index()  # type: ignore
  # compressed_df = pd.merge(la_df, lc_df, on=['author', 'file_name']) # type: ignore
  lc_df[['lines_added', 'lines_deleted']] = lc_df['line_count'].str.split(';', expand=True)
  lc_df.drop('line_count', axis=1, inplace=True)
  lc_df.dropna(subset=['lines_added', 'lines_deleted'], inplace=True)
  lc_df = lc_df[(lc_df['lines_added'] != 'nan') | (lc_df['lines_added'] != 'nan')]

  for col in ['lines_added', 'lines_deleted']:
    lc_df = lc_df[lc_df[col] != '-']
    lc_df[col] = pd.to_numeric(lc_df[col], errors='coerce')
  lc_df['net_line_changes'] = lc_df['lines_added'] - lc_df['lines_deleted']

  lc_df.to_csv(config['file_locations']['file_changes_cleaned'], index=False)

main()
