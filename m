From: vikram.pandita@ti.com (Pandita, Vikram)
Date: Thu, 10 Dec 2009 00:22:42 +0530
Subject: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8251@dbde02.ent.ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-3-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-4-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-5-git-send-email-santosh.shilimkar@ti.com>
	<1260383350-32681-6-git-send-email-santosh.shilimkar@ti.com>
	<FCCFB4CDC6E5564B9182F639FC35608702FAAFE85C@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02BC0A8251@dbde02.ent.ti.com>
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FAAFE85D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Shilimkar, Santosh
>Sent: Wednesday, December 09, 2009 12:49 PM
>To: Pandita, Vikram; tony at atomide.com
>Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; linux at arm.linux.org.uk
>Subject: RE: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
>
>> >-----Original Message-----
>> >From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of
>> >Shilimkar, Santosh
>> >Sent: Wednesday, December 09, 2009 12:29 PM
>> >To: tony at atomide.com
>> >Cc: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; linux at arm.linux.org.uk;
>> >Shilimkar, Santosh
>> >Subject: [PATCH 6/6] OMAP4: Sync up omap4430 defconfig
>> >
>> >Enable minimum features to boot omap4430 on es1.0 samples
>> >
>> >Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> >---
>> > arch/arm/configs/omap_4430sdp_defconfig |  146 ++++++++++++++++++-------------
>> > 1 files changed, 84 insertions(+), 62 deletions(-)
>> >
>> >diff --git a/arch/arm/configs/omap_4430sdp_defconfig b/arch/arm/configs/omap_4430sdp_defconfig
>> >index a464ca3..49df3ad 100644
>> >--- a/arch/arm/configs/omap_4430sdp_defconfig
>> >+++ b/arch/arm/configs/omap_4430sdp_defconfig
>> >@@ -1,26 +1,29 @@
>> > #
>> > # Automatically generated make config: don't edit
>> >-# Linux kernel version: 2.6.30-rc7
>> >-# Tue Jun  9 12:36:23 2009
>> >+# Linux kernel version: 2.6.32
>> >+# Sun Dec  6 23:37:45 2009
>> <snip>
>> >-# CONFIG_SYSFS_DEPRECATED=y is not set
>> >-# CONFIG_SYSFS_DEPRECATED_V2=y is not set
>> >+CONFIG_SYSFS_DEPRECATED_V2=y
>>
>> This is a deprecated feature and don't introduce it back again.
>> There haven been patches in recent past to get rid of this.
>Thanks Vikram. The thing is some of the busy box people are using get confused
>and stuck without this.

The reason is they have not upgraded to latest busybox yet.

>
>Do you have pointers to those patches ?

Here's the reference in k.org
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6502401d8169f76c6a72849cb55e8302226ca930

>
>Regards,
>Santosh
