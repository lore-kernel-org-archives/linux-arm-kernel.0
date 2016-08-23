From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:25:06 +0200
Subject: [PATCH v2 0/2] pinctrl: meson-gxbb: Export pins for PWMs
Message-ID: <1471951508-29620-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM pins in the meson-gxbb pinctrl driver and export then in the GXBB dtsi.

Changes since v1 at http://lkml.kernel.org/r/1471870450-11109-1-git-send-email-narmstrong at baylibre.com :
 - Rebased on git.linaro.org/people/linus.walleij/linux-pinctrl.git branch devel
 - Fixed previous rebase send on resend

Neil Armstrong (2):
  pinctrl: meson-gxbb: add pins for PWM
  ARM64: dts: meson-gxbb: Add PWM pinctrl nodes

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 77 ++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 79 +++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

-- 
1.9.1
