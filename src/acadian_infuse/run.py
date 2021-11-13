import src.utils as u
import toml
import re
import os
import pandas as pd
import numpy as np
from py_linq import Enumerable
import seaborn as sns
import matplotlib.pyplot as plt

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['file_data']
df: pd.DataFrame = pd.read_csv(csv_loc)  # type: ignore

bins = np.linspace(0, 125, 10)
print(bins)
df['line_count_cat'] = pd.cut(df['line_count'], bins=bins)


def file_type_binner(file_name):
  return 'react' if re.search(
      '\\.(tsx)$', file_name)\
      else 'typescript' if re.search(
      '\\.(ts)$', file_name)\
      else 'config' if re.search(
      '(\\.json$|ignore|docker)', file_name)\
      else 'resource'


def file_ext_binner(file_name):
  return re.sub('.*/(.*?)', '\\1', re.sub('.*\\.(.*?)', '\\1', string=file_name))


df['file_type'] = df['file_name'].apply(file_type_binner)
df['file_ext'] = df['file_name'].apply(file_ext_binner)

pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', 10000)
pd.set_option('display.max_colwidth', 200)

print(df.sample(5))

sns.set_theme()

aplot = sns.countplot(y='line_count_cat', data=df, hue='file_type')
plt.show()
