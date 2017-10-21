From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 Oct 2017 17:16:32 -0700
Subject: [GIT PULL 1/5] Broadcom soc changes for 4.15 (part 2)
Message-ID: <20171021001636.17662-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c14963521502b237a6817aceda6f3379296db75c:

  ARM: brcmstb: Add appropriate ARM_BE8() macros for swapping (2017-09-25 11:56:04 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.15/soc-part2

for you to fetch changes up to fa1e581d02d293d4d52c6950dc083484babe09f2:

  ARM: debug: Add Hurricane 2 UART2 debug addresses (2017-10-12 11:32:16 -0700)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoC changes for 4.15 (second
part), please pull the following:

- Florian adds support for the Broadcom Hurricane 2 SoC machine entry point
  and defines the debug UART address for use with earlyprintk/DEBUG_LL

----------------------------------------------------------------
Florian Fainelli (2):
      ARM: bcm: Add support for Broadcom Hurricane 2 SoC
      ARM: debug: Add Hurricane 2 UART2 debug addresses

 arch/arm/Kconfig.debug      | 10 +++++++++-
 arch/arm/mach-bcm/Kconfig   |  9 +++++++++
 arch/arm/mach-bcm/Makefile  |  3 +++
 arch/arm/mach-bcm/bcm_hr2.c | 25 +++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-bcm/bcm_hr2.c
