From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 30 Jul 2016 16:27:14 +0200
Subject: [PATCH 0/2] ASoC: Extended SPDIF support to Allwinner A31 SoCs
Message-ID: <20160730142716.29377-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

This patch set extends the current support of the Allwinner SPDIF
transceiver to include the A31 SoC.

For now just the SPDIF transmitter has been tested on the Mele I7.

In order for this patch set to be functional then we require changes
to the clocks and the device tree. For those that are interested I've
pushed all the required patches here

https://github.com/codekipper/linux-sunxi/commits/a31-spdif

Thanks in advance,
CK

Marcus Cooper (2):
  ASoC: sunxi: Add bindings for sun6i to SPDIF
  ASoC: sunxi: compatibility for sun6i to SPDIF

 .../devicetree/bindings/sound/sunxi,sun4i-spdif.txt     |  3 +++
 sound/soc/sunxi/sun4i-spdif.c                           | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.9.2
