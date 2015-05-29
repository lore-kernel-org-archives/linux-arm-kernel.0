From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 29 May 2015 14:54:48 -0700
Subject: [GIT PULL] Broadcom Device Tree changes for 4.2 (fixes)
Message-ID: <1432936488-20408-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 16dc3bac722252a10e396546f44135ae1b6a7ff3:

  ARM: BCM5301X: Add DT for Asus RT-AC56U (2015-05-13 11:32:24 -0700)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-4.2/dts-fixes

for you to fetch changes up to 9d7ef1b76c131f9b5e0a31fd1444d4fa6b8a841c:

  ARM: dts: BCM63xx: re-parent NAND controller node (2015-05-27 09:57:34 -0700)

----------------------------------------------------------------
This pull request contains a single change:

- fix the NAND controller node on bcm63138, the original change was a mis-merge that
  did not properly parent it to the "ubus" node

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: dts: BCM63xx: re-parent NAND controller node

 arch/arm/boot/dts/bcm63138.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)
