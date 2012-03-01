From: javier.martin@vista-silicon.com (javier Martin)
Date: Thu, 1 Mar 2012 09:37:54 +0100
Subject: [RFC] Merge 'arch/arm/mach-imx/dma-v1.c' into 'drivers/dma/imx-dma.c'
Message-ID: <CACKLOr0gR12p0i7nVeyLiMn3Bay01tj+5QTqV2QAcYeX+fxu=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
as you know my goal is implementing dma interleave support to imx-dma.
I tried this (among other things) with the following series:
[PATCH 0/4] dmaengine: i.MX DMA series.

However, patches 2 an 3 of the series modified 'drivers/dma/imx-dma.c'
file. So, Sascha and Vinod were quite reluctant to merge the series
just for that reason arguing that this file was meant to be removed.

Then I sent a v2 version of my series dropping the problematic patches:
[PATCH v2 0/2] dmaengine: i.MX DMA series.

I'm still encouraged to achieve my original goal of adding interleave
support but I don't want my work to be blocked again. For this purpose
I want to inform you previously that I will prepare another series
with the following patches:

1. Merge 'arch/arm/mach-imx/dma-v1.c' into 'drivers/dma/imx-dma.c'
2. Provide support for dma interleaved.

I will develop this on top of my previous series, so it would be great
if you could merge it as soon as possible in order to have a decent
base to work on.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
