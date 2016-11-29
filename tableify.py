import os

from jinja2 import Template

import xlrd

files = []

for item in os.listdir('hosted_files'):
    base = {
        'name': None,
        'section': None,
        'type': None,
        'link': None,
        }
    if '.' in item:
        name, extension = item.rsplit('.', 1)
        base['name'] = name.replace('_',' ')
        base['type'] = extension.replace('_',' ')
        base['section'] = 'Top Level'
        base['link'] = 'hosted_files/{}'.format(item)
        if 'DS_Store' not in extension:
            files.append(base)
    else:
        for subitem in os.listdir('hosted_files/' + item):
            base = {
                'name': None,
                'type': None,
                'link': None
            }
            if '.' in subitem:
                name, extension = subitem.rsplit('.', 1)
                base['name'] = name.replace('_',' ')
                base['type'] = extension.replace('_',' ')
                base['section'] = item.replace('_',' ')
                base['link'] = 'hosted_files/{}/{}'.format(item,subitem)
                if 'DS_Store' not in extension:
                    files.append(base)

info = []
files = [f for f in files if 'desktop.ini' not in f['link']]
"""
reference = 'hosted_files/DataManagementLibrary_ORCA_DataEntrySpreadsheet.xlsx'
xl_workbook = xlrd.open_workbook(reference)
sheet_names = xl_workbook.sheet_names()
"""
#https://blogs.harvard.edu/rprasad/2014/06/16/reading-excel-with-python-xlrd/
#print sheet_names

template = Template(open('templates/index.tpl').read())

with open('index.html', 'w+') as f:
    f.write(template.render(files=files))
