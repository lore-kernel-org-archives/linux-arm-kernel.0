From: merker@debian.org (Karsten Merker)
Date: Tue, 23 Jun 2015 19:02:27 +0200
Subject: [PATCH V4 0/2] MSI Primo 81 dts
In-Reply-To: <20150618115838.GL11732@lukather>
References: <20150618115838.GL11732@lukather>
Message-ID: <1435078949-3383-1-git-send-email-merker@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

following is V4 of the patchset to add MSI Primo 81 devicetree data.

Regards,
Karsten

Karsten Merker (2):
  ARM: dts: sun6i: Add dts file for MSI Primo81 tablet
  devicetree: Add msi to the vendor-prefix list

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           | 103 +++++++++++++++++++++
 3 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts

-- 
2.1.4
