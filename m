From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 02 Apr 2015 17:34:31 +0900
Subject: [PATCH 0/6] arm64: dts: exynos: Add USB/PWM/UART3/reboot dt node for
 Exynos5433 SoC
Message-ID: <1427963677-32661-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set add the following devicetree to support USB/PWM/UART3/reboot.
- USB 3.0 DRD (Dual Role Device) and host
- PWM (Pulse Width Modulation)
- UART3
- System reboot

Depend on:

This patch-set have the dependnecy on following patch[1] to support USB 3.0
Host and DRD (Dual Role Device) for Exynos5433 SoC. This patch[1] was merged
by Kishon Vijay Abraham I (GENERIC PHY FRAMEWORK maintainer).
[1] https://lkml.org/lkml/2015/3/25/984
    : [PATCH RESEND] phy: exynos5-usbdrd: Add to support for Exynos5433 SoC

Beomho Seo (1):
  arm64: dts: exynos: Add UART3 dt node for Exynos5433 SoC

Jaewon Kim (4):
  arm64: dts: exynos: Add EHCI and OHCI dt node for Exynos5433
  arm64: dts: exynos: Add USB Device dt node for Exynos5433
  arm64: dts: exynos: Add USB3.0 Host dt node for Exynos5433
  arm64: dts: exynos: Add PWM dt node and pinctrl for Exynos5433 SoC

Joonyoung Shim (1):
  arm64: dts: exynos: add reboot node for exynos5433

 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  35 +++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 167 +++++++++++++++++++++
 2 files changed, 202 insertions(+)

-- 
1.8.5.5
