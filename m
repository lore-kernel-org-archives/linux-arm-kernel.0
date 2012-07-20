From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 20 Jul 2012 17:40:00 +0200 (CEST)
Subject: mx1: compilation broken
Message-ID: <Pine.LNX.4.64.1207201734580.5505@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

mx1 camera compilation broken in current media-next 
(git://linuxtv.org/media_tree.git staging/for_v3.6):

In file included from linux/drivers/media/video/mx1_camera.c:44:
linux/arch/arm/mach-imx/include/mach/dma-mx1-mx2.h:8: fatal error: mach/dma-v1.h: No such file or directory

sorry, if this is already fixed in a more recent -next snapshot.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
