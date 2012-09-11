From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 11 Sep 2012 15:40:56 +0200 (CEST)
Subject: [PATCH 04/16] ARM: imx: move platform_data definitions
In-Reply-To: <1347368390-31252-4-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-4-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1209111538000.22084@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

It probably wouldn't be very difficult to also include 
arch/arm/plat-mxc/include/mach/ipu.h in this your patch, but you can also 
leave it for later. Just to make sure it's not something that would make 
your future patching more complicated.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
