import src.utils as u
import re
import toml
import os
import pandas as pd
import numpy as np
import functools as ft
from py_linq import Enumerable

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))
u.set_full_paths(config, this_dir)
csv_loc = config['file_locations']['raw_el_pollo_loco']

df: pd.DataFrame = pd.read_csv(csv_loc)  # type: ignore
df.columns = df.columns.str.lower()
pd.set_option('display.max_rows', df.shape[0] + 1)
pd.set_option('display.max_columns', df.shape[1] + 1)

for label in ['fat', 'protein', 'carbs']:
  df[label] = df[label].str.split('g', expand=True)[0]
  df[f'{label}_units'] = 'g'

df['calories'] = df.calories.astype('Int64')
df['category'] = df.main_food_link
df.drop(['web-scraper-order', 'web-scraper-start-url', 'main_food_link', 'main_food_link-href'], inplace=True, axis=1)
df['company'] = 'El Pollo Loco'
df.dropna(subset=['calories'], axis=0, inplace=True)
df[['serving_size','serving_size_units']] = df.serving_size.str.split(' ', expand=True)

ps = [
  # lambda: df.columns,
  lambda: df.sample(5),
  lambda: df.groupby(['category'])['calories'].mean().reset_index(),
  # lambda: df.serving_size_units.value_counts(dropna=False),
  # lambda: df.category.value_counts().nlargest(3).index,
  # lambda: df.sample(5),
  # lambda: df[['food', 'cal_per_gram', 'category']].groupby('category').food.agg(list),
]
for p in ps:
  print(p())

# df.to_csv(config['file_locations']['clean_el_pollo_loco'], index=False)
