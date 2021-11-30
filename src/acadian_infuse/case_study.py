import src.utils as u
import toml
import re
import os
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['case_study']
df: pd.DataFrame = pd.read_csv(csv_loc)  # type: ignore

upper_line_count_limit = 500
# bins = np.linspace(0, upper_line_count_limit, 10)
# df['line_count_cat'] = pd.cut(df['line_count'], bins=bins)

def file_type_binner(file_name):
  return 'config' if re.search(
      '(\\.json$|ignore|config|docker|ya?ml|gradle|setup|\\.toml$|\\.xml$)', file_name)\
      else 'script' if re.search(
      '(\\.(bat|(ba)?sh|ps1)$|([jJ]ustfile)$)', file_name)\
      else 'general_code' if re.search(
      '\\.([tjcfr]sx?|(cs)?html|vb|py|m)$', file_name)\
      else 'documentation' if re.search(
      '\\.(md|rst)$', file_name)\
      else 'resource'

df['file_type'] = df['file_name'].apply(file_type_binner)
df['file_ext'] = df['file_name']\
  .str.replace('.*\\.(.*?)', r'\1', regex=True)\
  .str.replace('.*/(.*?)', '\\1', regex=True)

pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', 10000)
pd.set_option('display.max_colwidth', 200)

# print(df.sample(5))

print(df['file_type'].value_counts())
print(df.groupby('file_type').agg(['mean']))
# print(df[df['file_type'] == 'config'])

# Limits data for charting purposes
df = df[~(df['lines_added'] > upper_line_count_limit)]
print(df)
# sns.set_theme()

# aplot = sns.countplot(y='line_count_cat', data=df, hue='file_type')
# plt.show()

aplot = sns.boxplot(y='file_type', x='lines_added', hue="author", data=df)
plt.show()