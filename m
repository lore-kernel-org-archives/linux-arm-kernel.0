From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Wed, 9 Jul 2014 14:05:30 +0530
Subject: [PATCH V2 0/2] ARM: DRA7: Add RTC hwmod and dt entries
In-Reply-To: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
References: <alpine.DEB.2.02.1407060031120.23762@utopia.booyaka.com>
Message-ID: <1404894932-26677-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds hwmod entry and dt node for RTC.

Tested on DRA7: logs can be seen here: http://hastebin.com/jaxogatuta.vhdl

Lokesh Vutla (2):
  ARM: DRA7: hwmod: Add data for RTC
  ARM: dts: DRA7: Add node for RTC

 arch/arm/boot/dts/dra7-evm.dts            |    1 +
 arch/arm/boot/dts/dra7.dtsi               |    9 +++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |   41 +++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

-- 
1.7.9.5
