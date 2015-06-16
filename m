From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 16 Jun 2015 09:52:45 -0700
Subject: [PATCH 0/2] ARM: ep93xx: vision_ep9307: minor updates
Message-ID: <1434473567-5258-1-git-send-email-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA for the SPI driver and add audio support.

H Hartley Sweeten (2):
  ARM: ep93xx: vision_ep9307: enable DMA for SPI
  ARM: ep93xx: vision_ep9307: add audio support

 arch/arm/mach-ep93xx/vision_ep9307.c | 61 ++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

-- 
2.3.0
