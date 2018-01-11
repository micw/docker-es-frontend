#!/usr/bin/env python

import argparse,re
from os import environ
from sys import exit

missing_vars=[]

def replace_var(match):
	var=match.group(1)
	if var in environ:
		return environ[var]

	missing_vars.append(var)
	return ""
	

def main():
	parser = argparse.ArgumentParser(description='Replace placeholders in config.')
	parser.add_argument('configfile', metavar='CONFIGFILE', help='Configfile to parse')
	parser.add_argument('outputfile', metavar='OUTPUTFILE', nargs='?', help='Optional output file. If ommitted, the configfile is overwritten')
	args = parser.parse_args()
	infile=args.configfile
	outfile=args.outputfile if args.outputfile else infile

	with open(infile, 'r') as instream:
		content = instream.read()

	content=re.sub("\${(.*?)}",replace_var,content)

	if len(missing_vars)>0:
		print
		print "Error processing %s:" % infile
		for missing_var in missing_vars:
			print " * Missing environment variable: %s" % missing_var
		print
		exit(1)

	with open(outfile, 'w') as outstream:
		outstream.write(content)

if __name__ == "__main__":
	main()