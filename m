From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Jan 2013 23:42:20 -0700
Subject: [GIT PULL 2/4] ARM: bcm2835: SoC driver updates
In-Reply-To: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
References: <1359441742-32647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359441742-32647-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bcm2835 clock driver is enhanced to allow fixed clocks to be probed
from device tree.

A system power-off implementation is added.

This branch is based on v3.8-rc3.

----------------------------------------------------------------

The following changes since commit 9931faca02c604c22335f5a935a501bb2ace6e20:

  Linux 3.8-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.9-soc

for you to fetch changes up to 45e9d77a22b7b25373c7b8c0ea0b146168025360:

  ARM: bcm2835: add a pm_power_off implementation

----------------------------------------------------------------

Dom Cobley (1):
      ARM: bcm2835: add a pm_power_off implementation

Stephen Warren (1):
      clk: bcm2835: probe for fixed-clock in device tree

 arch/arm/mach-bcm2835/bcm2835.c |   28 ++++++++++++++++++++++++++++
 drivers/clk/clk-bcm2835.c       |    9 +++++++++
 2 files changed, 37 insertions(+)
