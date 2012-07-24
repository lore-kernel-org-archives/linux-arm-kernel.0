From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Tue, 24 Jul 2012 13:13:04 +0530
Subject: [PATCH 0/2] ARM: davinci: da850/omap-l138: add support for VPIF driver
Message-ID: <1343115786-15801-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for VPIF
capture and display driver on da850/omap-l138.
Enables SD capture and display.

This patch series is dependent on [1] pull request.

[1] http://patchwork.linuxtv.org/patch/13305/

Manjunath Hadli (2):
  ARM: da850/omap-l138: Add SoC related definitions for VPIF
  ARM: da850/omap-l138: Add EVM specific code for VPIF to work

 arch/arm/mach-davinci/Kconfig              |    9 +
 arch/arm/mach-davinci/board-da850-evm.c    |  195 +++++++++++++++++++++
 arch/arm/mach-davinci/da850.c              |  256 ++++++++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |   11 ++
 arch/arm/mach-davinci/include/mach/mux.h   |   42 +++++
 arch/arm/mach-davinci/include/mach/psc.h   |    1 +
 6 files changed, 514 insertions(+), 0 deletions(-)
