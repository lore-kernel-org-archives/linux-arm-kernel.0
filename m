From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 18 Apr 2016 06:31:21 +0300
Subject: [PATCH 0/2] ARM: lpc32xx: updates to lpc32xx_defconfig
Message-ID: <1460950283-25053-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changeset updates lpc32xx_defconfig to match savedefconfig
and adds ARM PrimeCell PL175 memory controller driver to a build.

Vladimir Zapolskiy (2):
  ARM: LPC32xx: defconfig update
  ARM: LPC32xx: add PL175 memory controller driver to defconfig

 arch/arm/configs/lpc32xx_defconfig | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

-- 
2.1.4
