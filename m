From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Sat, 31 Jan 2015 19:58:43 -0300
Subject: [PATCH v4] DMAEngine support for sun4i, sun5i & sun7i
Message-ID: <1422745124-22103-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As part of Google Summer of Code 2014, I've worked on implementing
DMA support for the earlier Allwinner platforms. This fourth round of
patches is the result of said effort.

The previous versions of this set had some SPI patches, but I've
chosen to send them separately this time for the sake of clarity.
There were some DT patches as well, adding the corresponding nodes,
but those have been merged some time ago so I'm not including them
either. This leaves us with a single patch, which contains the actual
driver.

All comments, reviews and tests are welcome!

Thanks!

Emilio

Emilio L?pez (1):
  dma: sun4i: Add support for the DMA engine on sun[457]i SoCs

 .../devicetree/bindings/dma/sun4i-dma.txt          |   46 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/sun4i-dma.c                            | 1264 ++++++++++++++++++++
 4 files changed, 1322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 create mode 100644 drivers/dma/sun4i-dma.c

-- 
2.2.2
