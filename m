From: john@metanate.com (John Keeping)
Date: Tue, 23 Feb 2016 13:40:58 +0000
Subject: [PATCH 0/2] ARM: dts: rockchip: fix some interrupts on rk3288
Message-ID: <1456234860-18832-1-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

None of these are used by drivers so these don't fix any bugs but maybe
they'll save someone debugging time in the future.

John Keeping (2):
  ARM: dts: rockchip: fix MIPI interrupt on rk3288
  ARM: dts: rockchip: fix audio interrupts on rk3288

 arch/arm/boot/dts/rk3288.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.7.0.226.gfe986fe
