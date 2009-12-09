From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 10 Dec 2009 00:25:54 +0530
Subject: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FAAFE85D@dbde02.ent.ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-5-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-6-git-send-email-santosh.shilimkar@ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FAAFE85C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8251@dbde02.ent.ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FAAFE85D@dbde02.ent.ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8252@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> >> > # Automatically generated make config: don't edit
> >> >-# Linux kernel version: 2.6.30-rc7
> >> >-# Tue Jun  9 12:36:23 2009
> >> >+# Linux kernel version: 2.6.32
> >> >+# Sun Dec  6 23:37:45 2009
> >> <snip>
> >> >-# CONFIG_SYSFS_DEPRECATED=y is not set
> >> >-# CONFIG_SYSFS_DEPRECATED_V2=y is not set
> >> >+CONFIG_SYSFS_DEPRECATED_V2=y
> >>
> >> This is a deprecated feature and don't introduce it back again.
> >> There haven been patches in recent past to get rid of this.
> >Thanks Vikram. The thing is some of the busy box people are using get confused
> >and stuck without this.
> 
> The reason is they have not upgraded to latest busybox yet.
I guessed so. Time to upgrade the file system.
> >
> >Do you have pointers to those patches ?
> 
> Here's the reference in k.org
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commit;h=6502401d8169f76c6a72849cb55e8302226ca930
OK. Then we can get rid of this on OMAP4 too.

Regards,
Santosh
