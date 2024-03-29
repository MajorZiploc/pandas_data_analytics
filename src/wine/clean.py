import src.utils as u
import toml
import os
import pandas as pd
import functools as ft
from py_linq import Enumerable


this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['raw']

df: pd.DataFrame = pd.read_csv(csv_loc)  # type: ignore

# print(df.isnull().sum())

# print(df['country'].unique())

# print(df.duplicated().sum())
