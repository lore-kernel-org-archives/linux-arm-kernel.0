From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 4 Apr 2011 15:22:26 +0200
Subject: WARNING: at mm/page_alloc.c
Message-ID: <20110404132226.GA14806@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
I'm playing with uinput on zaurus (spitz) I've a pxa-2.6 kernel flashed in the
uinput is loaded as module. Right after my program called:

ioctl(fd, UI_DEV_CREATE);

I've got:

WARNING: at mm/page_alloc.c:2012 __alloc_pages_nodemask+0148/0x5a8()

and the ioctl() has failed.

Anybody has an idea what went wrong?
-- 
metan
