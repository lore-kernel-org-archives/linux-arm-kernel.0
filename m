From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 11:28:27 +0100
Subject: [PATCH 0/3] ARM: dts: Define stdout-patch for Exynos Chromebooks
Message-ID: <1426501710-24177-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kernel can use as the default console a serial port if is defined
as stdout device in the Device Tree.
    
This allows a board to be booted without the need of having a console
parameter in the kernel command line.

This small series add a stdout-path property for Exynos5 Chromebooks and
is composed of the following patches:

Javier Martinez Canillas (3):
  ARM: dts: Define stdout-path property for Peach boards
  ARM: dts: Define stdout-path property for Snow board
  ARM: dts: Define stdout-path property for Spring board

 arch/arm/boot/dts/exynos5250-snow.dts      | 1 +
 arch/arm/boot/dts/exynos5250-spring.dts    | 1 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 4 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 4 ++++
 4 files changed, 10 insertions(+)

Best regards,
Javier
