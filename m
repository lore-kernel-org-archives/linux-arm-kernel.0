From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 20 Feb 2016 11:46:20 -0800
Subject: [GIT PULL 1/8] Broadcom soc changes for 4.6
Message-ID: <1455997587-17564-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.6/soc

for you to fetch changes up to 6580566e10016c1ec00aa5e0e62af3c4b3498019:

  ARM: BCM63xx: Remove unused pmb_dn variable (2016-02-02 10:47:08 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC/platform changes:

- Masahiro updates the Broadcom Northstar Plus SMP operations to be annotated
  with const and __initconst

- Florian removes an unused variable in the Broadcom BCM63XX SMP code

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: BCM63xx: Remove unused pmb_dn variable

Masahiro Yamada (1):
      ARM: bcm: use const and __initconst for smp_operations

 arch/arm/mach-bcm/bcm63xx_pmb.c | 2 --
 arch/arm/mach-bcm/platsmp.c     | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)
