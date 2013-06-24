From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 24 Jun 2013 12:35:15 +0200
Subject: [PATCH 0/3] ARM: at91/DT: enable SPI for more SoCs
Message-ID: <cover.1372069834.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This little series is for enabling the support of SPI on at91sam9n12 and
sama5d3 families.

Nicolas Ferre (3):
  ARM: at91/DT: fix SPI compatibility string
  ARM: at91/DT: sama5d3: add SPI DMA client infos
  ARM: at91/DT: at91sam9n12: add SPI DMA client infos

 arch/arm/boot/dts/at91sam9n12.dtsi |  6 ++++++
 arch/arm/boot/dts/sama5d3.dtsi     | 10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.8.2.2
