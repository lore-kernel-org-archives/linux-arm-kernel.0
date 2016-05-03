From: mike@mikebwilliams.com (Mike Williams)
Date: Tue,  3 May 2016 12:44:21 -0400
Subject: [PATCH 0/3] ARM: at91/dt: add SAMA5 trng nodes
Message-ID: <1462293864-32551-1-git-send-email-mike@mikebwilliams.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for the true hardware random number generator.

Tested on a SAMA5D3 Xplained board.

Mike Williams (3):
  ARM: at91/dt: sama5d2: add trng node
  ARM: at91/dt: sama5d3: add trng node
  ARM: at91/dt: sama5d4: add trng node

 arch/arm/boot/dts/sama5d2.dtsi | 7 +++++++
 arch/arm/boot/dts/sama5d3.dtsi | 7 +++++++
 arch/arm/boot/dts/sama5d4.dtsi | 7 +++++++
 3 files changed, 21 insertions(+)

-- 
2.5.0
