From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 Feb 2015 13:02:44 -0800
Subject: [GIT PULL] Broadcom Device Tree changes for 3.20
Message-ID: <1424120564-32721-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  http://github.com/broadcom/stblinux tags/arm-soc/for-3.20/dts

for you to fetch changes up to b51c05a331ff46d2b29e4007df938ec2dbbadfde:

  ARM: dts: add I2C device nodes for Broadcom Cygnus (2015-02-16 12:50:39 -0800)

----------------------------------------------------------------
This pull request contains the following Broadcom SoCs Device Tree changes:

- Ray adds support for the Cygnus i2c Device Tree controller on Cygnus SoCs
- Fixes to the BCM63138 dtsi file for the L2 cache controller properties

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: dts: BCM63xx: fix L2 cache properties

Ray Jui (1):
      ARM: dts: add I2C device nodes for Broadcom Cygnus

 arch/arm/boot/dts/bcm-cygnus.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/bcm63138.dtsi   |  5 +++--
 2 files changed, 23 insertions(+), 2 deletions(-)
