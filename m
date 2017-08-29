From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 29 Aug 2017 12:51:25 +0800
Subject: [PATCH RESEND 0/2] Allwinner V3s DMA support
Message-ID: <20170829045127.19951-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a dedicated patchset of Allwinner V3s DMA support, which used
to be part of the audio codec support patchset.

It's a derivation of the DMA part of v3 of the codec patchset.

Icenowy Zheng (2):
  dmaengine: sun6i: make gate bit in sun8i's DMA engines a common quirk
  dmaengine: sun6i: support V3s SoC variant

 .../devicetree/bindings/dma/sun6i-dma.txt          |  1 +
 drivers/dma/sun6i-dma.c                            | 33 +++++++++++++++++-----
 2 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.13.5
