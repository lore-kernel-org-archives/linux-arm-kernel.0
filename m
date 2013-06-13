From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Jun 2013 04:05:37 -0700
Subject: [PATCH 2/6] ARM: OMAP2+: Remove board-omap4panda.c
In-Reply-To: <51B99B07.1050806@ti.com>
References: <20130517191304.468.73487.stgit@localhost>
 <20130517191753.468.1734.stgit@localhost>
 <CACVXFVOp6n3RhZnWD_hRxqE8a8amPA5SRWfkVhz+yCGZTtGjvQ@mail.gmail.com>
 <20130612163124.GD8164@atomide.com>
 <20130612171407.GM8164@atomide.com> <51B98F1E.1000006@ti.com>
 <51B99B07.1050806@ti.com>
Message-ID: <20130613110537.GC8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [130613 03:18]:
> >  
> > I tried your cleanup branch omap-for-v3.11/cleanup on panda board and it booted
> >  to prompt fine.
> >             Hardware: Pandaboard A1   dtb: omap4-panda.dtb

OK thanks for testing.

> >   git pull on linux-next branch was not working though.
> >
>     Ok, tested in linux-next as well and it booted fine with DTB.
>      HW: OMAP4430ES2.1 PANDA A1 version DTB: OMAP4-PANDA.DTB
>   
>     Booted with ramdisk and mmc FS
> 
> commit c04efed734409f5a44715b54a6ca1b54b0ccf215
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Fri Jun 7 16:40:02 2013 +1000
> 
>     Add linux-next specific files for 20130607

OK thanks for testing that too. I don't think these patches are
in linux-next yet. But still good to hear it works.

Ming Lei, any further info on your board?

Regards,

Tony
