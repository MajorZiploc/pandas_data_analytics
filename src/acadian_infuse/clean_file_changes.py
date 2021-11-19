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
csv_loc = config['file_locations']['file_changes_raw']

df: pd.DataFrame = pd.read_csv(csv_loc)  # type: ignore

pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', 10000)
pd.set_option('display.max_colwidth', 200)

# print(df.sample(5))

grouped_df = df.groupby(['author', 'file_name'])

for key, item in grouped_df:
  print(grouped_df.get_group(key))
