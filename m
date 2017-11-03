From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Nov 2017 17:43:12 +0100
Subject: [PATCH 0/2] ARM: dts: exynos: Updates for Odroid HDMI audio
References: <CGME20171103164358epcas2p1556289ae7a9f2e29da932fc24651d592@epcas2p1.samsung.com>
Message-ID: <20171103164314.14919-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are intended for v4.16-rc1 as they depend on the
HDMI codec patch which is going to be merged in coming merge
window.

Sylwester Nawrocki (2):
  ARM: dts: exynos: Switch to dedicated Odroid-XU3 sound card binding
  ARM: dts: exynos: Add sound support for Odroid XU4

 arch/arm/boot/dts/exynos4.dtsi                    |  1 +
 arch/arm/boot/dts/exynos5420.dtsi                 |  1 +
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 64 ++++++++++++++--------
 arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi | 67 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        |  1 +
 5 files changed, 111 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi

--
2.14.2
