From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 28 Mar 2013 17:21:07 +0100
Subject: [PATCH 0/2] pinctrl support for ab8500-usb
Message-ID: <1364487669-24368-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

this contains the required definitions for ab8500-usb pinctrl sleep and
default modes, and a non-related patch to drop a macro redefinition.

Thanks,
Fabio

Fabio Baltieri (1):
  ARM: ux500: remove redundant DB8500_PIN_SLEEP definition

Patrice Chotard (1):
  ARM: ux500: 8500: add ab8500-musb pinctrl support

 arch/arm/mach-ux500/board-mop500-pins.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

-- 
1.8.1.3
