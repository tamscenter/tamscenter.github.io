import os

from jinja2 import Template

import xlrd

import time

files = []

for item in os.listdir('hosted_files'):
    print item
    if '.' in item:
        name, extension = item.rsplit('.', 1)
        base = {
            'name': name.replace('_',' '),
            'section': 'Top Level',
            'type': extension.replace('_',' '),
            'link': 'hosted_files/{}'.format(item),
        }
        files.append(base)
    else:
        try:
            for subitem in os.listdir('hosted_files/' + item):
                print 'SUBITEM: {}'.format(subitem)
                if '.' in subitem:
                    name, extension = subitem.rsplit('.', 1)
                    base = {
                        'name': name.replace('_',' '),
                        'section': item.replace('_',' '),
                        'type': extension.replace('_',' '),
                        'link': 'hosted_files/{}/{}'.format(item, subitem)
                    }
                    files.append(base)
        except Exception as e:
            print e
            continue

info = []
files = [f for f in files if 'desktop.ini' not in f['link'] and 'DS_Store' not in f['link']]

# Checking Code
# print len(files)
# time.sleep(30)

# with open('check.txt', 'w+') as f:
#     f.write(str(files[0]))

"""
TODO: Add Metadata:
# https://blogs.harvard.edu/rprasad/2014/06/16/reading-excel-with-python-xlrd/
reference = 'hosted_files/DataManagementLibrary_ORCA_DataEntrySpreadsheet.xlsx'
xl_workbook = xlrd.open_workbook(reference)
sheet_names = xl_workbook.sheet_names()
"""

template = Template(open('templates/index.tpl').read())

with open('index.html', 'w+') as f:
    f.write(template.render(files=files))
