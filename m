From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 10:58:59 +0900
Subject: [PATCH 0/4] ARM: shmobile: ape6evm: support GPIO switches and LEDs
Message-ID: <1375149543-27564-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This short series adds support for GPIO swtiches and LEDS to
the ape6evm board.

Applies on top of renesas-devel-20130726.

Simon Horman (4):
  ARM: shmobile: ape6evm: support GPIO switches
  ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
  ARM: shmobile: ape6evm: Add GPIO LEDs
  ARM: shmobile: ape6evm: Enable gpio-leds in defconfig

 arch/arm/configs/ape6evm_defconfig     |  6 +++-
 arch/arm/mach-shmobile/board-ape6evm.c | 60 ++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

-- 
1.8.3.2
