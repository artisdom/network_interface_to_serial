/*
  File: acl_equiv_mode.c

  Copyright (C) 1999, 2000
  Andreas Gruenbacher, <a.gruenbacher@bestbits.at>

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2 of the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

#include <stdio.h>
#include <errno.h>
#include <sys/stat.h>
#include <acl/libacl.h>
#include "libacl.h"


int
acl_equiv_mode(acl_t acl, mode_t *mode_p)
{
	acl_obj *acl_obj_p = ext2int(acl, acl);
	acl_entry_obj *entry_obj_p;
	int not_equiv = 0;
	mode_t mode = 0;
	if (!acl_obj_p)
		return -1;
	FOREACH_ACL_ENTRY(entry_obj_p, acl_obj_p) {
		switch(entry_obj_p->etag) {
			case ACL_USER_OBJ:
				mode |= (entry_obj_p->eperm.sperm
				         & S_IRWXO) << 6;
				break;
			case ACL_GROUP_OBJ:
				mode |= (entry_obj_p->eperm.sperm &
				         S_IRWXO) << 3;
				break;
			case ACL_OTHER:
				mode |= (entry_obj_p->eperm.sperm &
				         S_IRWXO);
				break;
			case ACL_USER:
			case ACL_GROUP:
			case ACL_MASK:
				not_equiv = 1;
				break;
			default:
				errno = EINVAL;
				return -1;
		}
	}
	if (mode_p)
		*mode_p = mode;
	return not_equiv;
}

