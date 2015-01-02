From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  2 Jan 2015 16:24:13 +0100
Subject: [PATCH RESEND 0/4] Small updates to Snow and Peach Pit/Pi DTS
Message-ID: <1420212257-22443-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

This series adds some DTS snippets that were missing in the mainline
Snow and Peach Pit/Pi Device Trees but are present in the downstream
ChromeOS kernel.

The series is composed of the following patches:

Javier Martinez Canillas (4):
  ARM: dts: Add power and lid GPIO keys pinctrl for exynos5250-snow
  ARM: dts: Add lid GPIO key device node for Peach boards
  ARM: dts: Set Peach boards USB WebCam regulators to always on
  ARM: dts: Configure regulators for suspend on exynos Peach boards

 arch/arm/boot/dts/exynos5250-snow.dts      |  16 +++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 100 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 101 ++++++++++++++++++++++++++++-
 3 files changed, 215 insertions(+), 2 deletions(-)

Patch #1 adds some pinctrl lines for the GPIO keys in the Snow DTS.

Patch #2 adds a device node and pinctrl lines for the lid GPIO in
the Peach boards DTS.

Patch #3 sets the regulators that supply voltage to the USB WebCam
in Peach boards as always on.

Patch #4 configures the max77802 regulators on the Peach Pit and Pi
boards to be enabled or disabled during system suspend.

Best regards,
Javier
