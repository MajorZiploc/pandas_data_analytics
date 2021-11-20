import src.utils as u
import toml
import os
import pandas as pd

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

summed_df.to_csv(config['file_locations']['file_changes_cleaned'], index=False)
