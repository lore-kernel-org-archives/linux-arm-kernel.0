From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 22 Aug 2016 16:40:58 +0200
Subject: [RESEND PATCH 0/2] pinctrl: meson-gxbb: Export pins for PWMs
Message-ID: <1471876860-5620-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PWM pins in the meson-gxbb pinctrl driver and export then in the GXBB dtsi.

Resent rebased on git.linaro.org/people/linus.walleij/linux-pinctrl.git branch devel.

Neil Armstrong (2):
  pinctrl: meson-gxbb: add pins for PWM
  ARM64: dts: meson-gxbb: Add PWM pinctrl nodes

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 77 ++++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c  | 78 +++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+)

-- 
1.9.1
