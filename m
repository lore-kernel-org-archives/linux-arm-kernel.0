From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 21 May 2013 19:37:58 +0530
Subject: [PATCH 0/3] pinctrl: pinctrl-single: Add full fledge support to
 configure multiple pins of different modules
Message-ID: <1369145282-14419-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based function-mask and submask preoperties patch allocates and registers pins.
Patch is fixes the issue reported and discussed here:
http://www.spinics.net/lists/arm-kernel/msg235213.html

Applies on top of 3.10-rc2 of linus's tree.

Tested on da850-evm.

Manjunathappa, Prakash (3):
  pinctrl: pinctrl-single: enhance to configure multiple pins of
    different     modules
  pinctrl: pinctrl-single: pin names for pinctrl-single.bits
  ARM: davinci: da850: adopt to pinctrl-single driver to configure
    multiple     pins

 .../devicetree/bindings/pinctrl/pinctrl-single.txt |    3 +-
 arch/arm/boot/dts/da850.dtsi                       |    2 +-
 drivers/pinctrl/pinctrl-single.c                   |  215 ++++++++++++++++----
 3 files changed, 179 insertions(+), 41 deletions(-)

-- 
1.7.4.1
