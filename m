From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Dec 2015 21:01:19 -0800
Subject: [GIT PULL 1/4] BCM2835 SOC changes for 4.5
In-Reply-To: <1451365282-10505-1-git-send-email-eric@anholt.net>
References: <1451365282-10505-1-git-send-email-eric@anholt.net>
Message-ID: <1451365282-10505-2-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f74875dc36135ebae82a8e005f4b7f52289d2c40:

  usb: dwc2: fix kernel oops during driver probe (2015-11-20 09:29:47 -0600)

are available in the git repository at:

  http://github.com/anholt/linux tags/bcm2835-soc-next-2015-12-28

for you to fetch changes up to 5234c34e4cd7695647ccc1cabb50c3e7720dd3fb:

  ARM: bcm2835: Add Kconfig support for bcm2836 (2015-12-26 14:34:03 -0800)

----------------------------------------------------------------
This pull request includes the bcm2835 changes for 4.5 targeting the
arm-soc next/soc branch.

----------------------------------------------------------------
Eric Anholt (3):
      dt-bindings: Add root properties for Raspberry Pi 2
      ARM: bcm2835: Add a compat string for bcm2836 machine probe
      ARM: bcm2835: Add Kconfig support for bcm2836

 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt |  4 ++++
 arch/arm/Kconfig.debug                                     | 10 ++++++++--
 arch/arm/mach-bcm/Kconfig                                  |  9 +++++----
 arch/arm/mach-bcm/board_bcm2835.c                          |  5 +++++
 4 files changed, 22 insertions(+), 6 deletions(-)
