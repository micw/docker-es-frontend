#!/usr/bin/env python

from os import environ
import argparse,re

def main():
    parser = argparse.ArgumentParser(description='Generate htpasswd from USERS environment variable')
    parser.add_argument('outfile', metavar='OUTFILE', help='Path to new htpasswd file')
    args = parser.parse_args()
    outfile=args.outfile
    users=[]

    has_users=False
    if 'USERS' in environ:
        for user_pass in environ['USERS'].split():
            (u,p)=user_pass.split(':',1)
            if not p.startswith('$2y$'):
                print "WARNING: For security reasons, only bcrypt passwords are accepted (starting with $2y$) - skipping user %s" % u
                continue
            print "INFO: Adding user %s" % u
            users.append("%s:%s"%(u,p))

    print "INFO: Writing users to %s"%outfile
    with open(outfile,'w') as out:
        out.write("\n".join(users))
        out.write("\n");

    if len(users):
        print "INFO: Added %s users "%len(users)
    else:
        print "WARNING: No users added. You will not be able to log-in"


if __name__ == "__main__":
    main()
