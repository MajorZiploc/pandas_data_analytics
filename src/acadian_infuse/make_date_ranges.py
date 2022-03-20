import datetime

def main():
  date_format = '%m/%d/%Y'
  today = datetime.datetime.today()
  start = datetime.datetime.strptime('08/01/2021', date_format)
  day_step = 7
  date_range_list = []
  while (start < today):
    start_of_range = start.strftime(date_format)
    start = start + datetime.timedelta(days=day_step)
    end_of_range = start.strftime(date_format)
    date_range_list.append(f'{start_of_range}~{end_of_range}')
  print(' '.join(date_range_list))

main()

