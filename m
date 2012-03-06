From: javier.martin@vista-silicon.com (javier Martin)
Date: Tue, 6 Mar 2012 12:03:54 +0100
Subject: Problems with "[PATCH 0/9] DMA engine cookie handling cleanups"
Message-ID: <CACKLOr3zFmNXYV6MW01uykp7geG=1gAkWcxYoMgLdqfzhMD9fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,
I've just seen this series in the mailing list archives:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087917.html

As some people already stated, patch 1/9 is missing.
In my case it is even worse: I didn't received any of the patches in
my mail-box despite being subscribed to the list.

As you'll probably have noticed, I'm doing some deep cleanup on
'imx-dma.c' file as you can see in the following patches:

[PATCH v2 1/2] dmaengine: Add support for MEMCPY for imx-dma.
[PATCH v3 2/2] dmaengine: Add support for multiple descriptors for imx-dma.
[PATCH 00/14] dmaengine: imx-dma: merge dma arch code into dmaengine.

Currently, I'm waiting for Sascha and Vinod to confirm that they are
fine and merge them. However, your series seems to conflict with those
patches as it modifies imx-dma.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
