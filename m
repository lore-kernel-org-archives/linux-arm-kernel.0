From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri,  7 Jun 2013 16:37:12 +0530
Subject: [PATCH 0/3] Add display support for Origen board
Message-ID: <1370603235-11193-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches are based in Kukjin's for-next branch.

Sachin Kamat (2):
  ARM: dts: exynos4210: Add LCD related pinctrl entries
  ARM: dts: Add FIMD node to Origen4210 board

Tushar Behera (1):
  ARM: dts: Set BUCK7 as always on for Origen board

 arch/arm/boot/dts/exynos4210-origen.dts   |   22 +++++++++
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi |   75 +++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

-- 
1.7.9.5
