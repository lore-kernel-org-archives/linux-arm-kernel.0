From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue, 21 Apr 2015 14:05:11 +0200
Subject: [PATCH v2 0/7] ARM: at91/dt: kizbox: update and rename to at91-kizbox
Message-ID: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*** BLURB HERE ***

Ga?l PORTAY (7):
  ARM: at91/dt: kizbox: rename to at91-kizbox
  ARM: at91/dt: at91-kizbox: sanitize file
  ARM: at91/dt: at91-kizbox: user proper serial uart
  ARM: at91/dt: at91-kizbox: gpio-keys related changes
  ARM: at91/dt: at91-kizbox: leds related changes
  ARM: at91/dt: at91-kizbox: re-size nand partitions
  ARM: at91/dt: at91-kizbox: update chosen node

 arch/arm/boot/dts/Makefile        |   2 +-
 arch/arm/boot/dts/at91-kizbox.dts | 159 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kizbox.dts      | 150 -----------------------------------
 3 files changed, 160 insertions(+), 151 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizbox.dts
 delete mode 100644 arch/arm/boot/dts/kizbox.dts

-- 
1.9.1
