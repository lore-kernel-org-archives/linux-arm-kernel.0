From: utx@penguin.cz (Stanislav Brabec)
Date: Wed, 13 Jan 2010 14:42:41 +0100
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <20100113114651.GJ8970@buzzloop.caiaq.de>
References: <20091031013427.GL14091@buzzloop.caiaq.de>
	<20091101205449.GT14091@buzzloop.caiaq.de>
	<20091101213343.GA31345@elf.ucw.cz> <20091101220341.GA16698@elf.ucw.cz>
	<771cded00911020122o3bb5cc96q957c8be1ce7cae46@mail.gmail.com>
	<1257155873.5642.14.camel@utx.utx.cz>
	<771cded00911021931x41cfa51bh2959d3748db5ac0@mail.gmail.com>
	<1257241821.4269.5.camel@utx.utx.cz>
	<771cded00911042106u39fd3655mae50a89bd419411b@mail.gmail.com>
	<20100113114651.GJ8970@buzzloop.caiaq.de>
Message-ID: <1263390161.5419.9.camel@hammer.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:

> It seems Stanislav's patch is still unmerged in the current git HEAD.
> Any idea why it is held back? I have it applied locally since quite a
> while here, and it works well. So if it helps, take my Tested-by: for
> it.

It seems to be on the right way:

From: gregkh@suse.de
Subject: patch serial-core-resume-serial-hardware-with-no_console_suspend.patch added to gregkh-2.6 tree
Date: Tue, 22 Dec 2009 12:22:35 -0800

This is a note to let you know that I've just added the patch titled

    Subject: serial-core: resume serial hardware with no_console_suspend

to my gregkh-2.6 tree.  Its filename is

    serial-core-resume-serial-hardware-with-no_console_suspend.patch

This tree can be found at 

http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec at suse.cz
Lihovarsk? 1060/12           tel: +420 284 028 966, +49 911 740538747
190 00 Praha 9                                  fax: +420 284 028 951
Czech Republic                                    http://www.suse.cz/
