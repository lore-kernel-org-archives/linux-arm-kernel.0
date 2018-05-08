From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue,  8 May 2018 10:01:00 -0700
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.17
Message-ID: <20180508170100.21196-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.17/devicetree-fixes

for you to fetch changes up to 675c7215aacf54242b2e8bc64bab698abbe764db:

  ARM: dts: cygnus: fix irq type for arm global timer (2018-05-07 11:21:18 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-basec SoCs Device Tree fixes for
4.17, please pull the following:

- Clement fixes in an incorrect trigger type for the ARM global timers
  on the Cygnus platforms

----------------------------------------------------------------
Cl?ment P?ron (1):
      ARM: dts: cygnus: fix irq type for arm global timer

 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
