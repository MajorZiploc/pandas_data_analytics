import pdfplumber
from py_linq import Enumerable
import toml
import os
import pandas_data_analytics.utils as u
from pandas_data_analytics.text_parser.parser import Parser
import re

this_dir = os.path.dirname(os.path.realpath(__file__))
config = toml.load(os.path.join(this_dir, 'config.toml'))

u.set_full_paths(config, this_dir)
pdf_loc = config['file_locations']['data']

parser_settings = toml.load(os.path.join(this_dir, 'pdf_config.toml'))
parser = Parser(parser_settings)

m = re.sub('.*?(\w+).*', '\\1', '  words ')
m = re.sub('.*?Patient #: (\d+) Capture:.*', '\\1', '  Patient #: 234234 Capture:23 ')
# m = re.search('.*?(\w+).*?', '\\1', '  words ')
# m2 = ', '.join(re.findall('words (\w+)', '  words  pa'))

with pdfplumber.open(pdf_loc) as pdf:
    all_txt = Enumerable(pdf.pages).aggregate(lambda acc, page: acc+page.extract_text(), "")
    result = parser.parse(all_txt)
    print(result['milk'])
