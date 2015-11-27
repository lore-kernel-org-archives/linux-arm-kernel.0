From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 27 Nov 2015 10:52:44 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a7793: Increase scif support
Message-ID: <1448589166-11612-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this short series enables DMA for serial devices already present
and then adds missing serial ports to the r8a7793 device tree.

This is based on prior work for the r8a7791 SoC by Laurent Pinchart.

Lightly tested on top of renesas-devel-20151126-v4.4-rc2.

Simon Horman (2):
  ARM: shmobile: r8a7793: Add missing serial devices to DT
  ARM: shmobile: r8a7793: Describe DMA for the serial ports

 arch/arm/boot/dts/r8a7793.dtsi | 215 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 2 deletions(-)

-- 
2.1.4
