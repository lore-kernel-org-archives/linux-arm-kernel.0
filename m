From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 12 Dec 2014 11:25:48 +0100
Subject: [PATCH 0/3] Small updates to Snow and Peach Pit/Pi DTS
Message-ID: <1418379951-5551-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

This series adds some DTS snippets that were missing in the mainline
Snow and Peach Pit/Pi Device Trees but are present in the downstream
ChromeOS kernel.

The series is composed of the following patches:

Javier Martinez Canillas (3):
  ARM: dts: Add power and lid GPIO keys pinctrl for exynos5250-snow
  ARM: dts: Add lid GPIO key device node for Peach boards
  ARM: dts: Set Peach boards USB WebCam regulators to always on

 arch/arm/boot/dts/exynos5250-snow.dts      | 16 ++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 19 ++++++++++++++++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 20 +++++++++++++++++++-
 3 files changed, 53 insertions(+), 2 deletions(-)

Patch #1 adds some pinctrl lines for the GPIO keys in the Snow DTS.

Patch #2 adds a device node and pinctrl lines for the lid GPIO in
the Peach boards DTS.

Patch #3 sets the regulators that supply voltage to the USB WebCam
in Peach boards as always on.

Best regards,
Javier
