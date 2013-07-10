From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 10 Jul 2013 17:44:07 +0530
Subject: [PATCH 0/2] Move comon DMA nodes to exynos5.dtsi and
Message-ID: <1373458449-19039-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5250 and Exynos5420 has 4 DMA controllers in common. So this patch
set moved the common nodes to exynos.dtsi keeping the clk info seperate
for both the platforms. Exynos5420 has a separate DMA controller for audio
IPs. So this patch set also adds the ADMA node on Exynos5420.

Padmavathi Venna (2):
  ARM: dts: Move the common DMA controller nodes to exynos5.dtsi
  ARM: dts: Add DMA controller node info on Exynos5420.

 arch/arm/boot/dts/exynos5.dtsi    |   44 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi |   30 -------------------------
 arch/arm/boot/dts/exynos5420.dtsi |   33 +++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 30 deletions(-)

-- 
1.7.4.4
