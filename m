From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Jan 2015 15:22:33 -0800
Subject: [PATCH 0/2] Add clockdomain and hwmod data needed to boot dm816x
Message-ID: <1421191355-12835-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches add the basic data needed for booting dm816x
after the fixes I posted earlier today. Note that also the
device tree related changes are needed that will be posted
in another series.

Regards,

Tony


Aida Mynzhasova (1):
  ARM: OMAP2+: Add clock domain support for dm816x

Tony Lindgren (1):
  ARM: OMAP2+: Add dm816x hwmod support

 arch/arm/mach-omap2/Makefile                |    3 +
 arch/arm/mach-omap2/clockdomain.h           |    1 +
 arch/arm/mach-omap2/clockdomains81xx_data.c |  191 +++++
 arch/arm/mach-omap2/cm81xx.h                |   61 ++
 arch/arm/mach-omap2/io.c                    |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c            |    2 +-
 arch/arm/mach-omap2/omap_hwmod.h            |    1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 1025 +++++++++++++++++++++++++++
 8 files changed, 1291 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm81xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_81xx_data.c

-- 
2.1.4
