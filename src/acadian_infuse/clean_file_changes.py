import src.utils as u
import toml
import os
import pandas as pd

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['file_changes_raw']

df: pd.DataFrame = pd.read_csv(csv_loc)  # type: ignore
df = df[df['lines_added'] != '-']
df = df[df['lines_deleted'] != '-']
df['lines_deleted'] = pd.to_numeric(df['lines_deleted'])
df['lines_added'] = pd.to_numeric(df['lines_added'])
df.convert_dtypes()
print(df.dtypes)

pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', 10000)
pd.set_option('display.max_colwidth', 200)

# print(df.sample(5))
# sum up all line adds and deletes per author per file
summed_grouped_df = df.groupby(['author', 'file_name']).agg('sum')
summed_df: pd.DataFrame = summed_grouped_df.unstack().unstack().reset_index()  # type: ignore
summed_df.rename(columns={'level_0': 'line_action', 0: 'line_count'}, inplace=True)
#summed_df['line_count'] = summed_df['line_count'].astype('Int64')
# print(summed_df)

summed_df.to_csv(config['file_locations']['file_changes_cleaned'], index=False)

# grouped_df = df.groupby(['author', 'file_name'])

# for key, item in grouped_df:
#  print(grouped_df.get_group(key))
