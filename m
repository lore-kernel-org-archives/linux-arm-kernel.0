From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2012 10:41:47 +0100
Subject: [GIT PULL] ux500 fixes due for v3.7 RCs
Message-ID: <20121025094147.GA4008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ljones/linux-3.0-ux500.git for-rcs-3.7

for you to fetch changes up to 76ff4e434734f7772d1a592cc9fe1d9921a3ec40:

  ARM: ux500: Correct SDI5 address and add some format changes (2012-10-25 08:46:20 +0100)

----------------------------------------------------------------
Lee Jones (3):
      ARM: ux500: Fix build error relating to IRQCHIP_SKIP_SET_WAKE
      ARM: ux500: Specify AMBA Primecell IDs for Nomadik I2C in DT
      ARM: ux500: Correct SDI5 address and add some format changes

 arch/arm/boot/dts/dbx5x0.dtsi |   17 ++++++++++++++++-
 arch/arm/mach-ux500/cpu.c     |    1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
