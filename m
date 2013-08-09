From: vikram186@gmail.com (Vikram Narayanan)
Date: Fri, 09 Aug 2013 15:14:11 +0530
Subject: Ti-st suspend/resume hooks
Message-ID: <5204B9EB.4020809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Our i.Mx6 based platform has a wl12xx chip and the ti-st driver is in 
use. When the system goes to suspend, the st_kim module fails to suspend 
giving out -EOPNOTSUPP [1], which is quite evident from the the missing 
suspend/resume hooks in the wilink_platform_data. [2]

Are there any ways to make this ti-st driver suspend/resume aware?

Thanks,
Vikram

[1] http://lxr.linux.no/linux+v3.10.5/drivers/misc/ti-st/st_kim.c#L833

[2] 
http://lxr.linux.no/linux+v3.10.5/arch/arm/mach-omap2/board-omap4panda.c#L58

P.S: I'm not subscribed to the list. Please keep me Cc'd.
