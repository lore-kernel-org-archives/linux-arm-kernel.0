From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Oct 2015 23:18:55 +0800
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.4
Message-ID: <1445267937-2952-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.4

for you to fetch changes up to 7f7308198f98700be82d123569ea59229a75d3c3:

  ARM: imx: add cpufreq device for imx6ul (2015-10-12 21:47:22 +0800)

----------------------------------------------------------------
The i.MX SoC updates for 4.4:
 - Enable suspend and cpufreq support for i.MX6UL
 - Add platform level ENET initialization support for i.MX7D

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: add suspend/resume support for i.mx6ul

Bai Ping (1):
      ARM: imx: add cpufreq device for imx6ul

Fugang Duan (2):
      ARM: imx7d: add imx7d iomux-gpr field define
      ARM: imx: add enet init for i.MX7D platform

 arch/arm/mach-imx/common.h                 |  1 +
 arch/arm/mach-imx/mach-imx6ul.c            |  9 ++++
 arch/arm/mach-imx/mach-imx7d.c             | 74 ++++++++++++++++++++++++++++++
 arch/arm/mach-imx/pm-imx6.c                | 46 ++++++++++++++++---
 arch/arm/mach-imx/suspend-imx6.S           |  3 ++
 include/linux/mfd/syscon/imx7-iomuxc-gpr.h | 47 +++++++++++++++++++
 6 files changed, 174 insertions(+), 6 deletions(-)
 create mode 100644 include/linux/mfd/syscon/imx7-iomuxc-gpr.h
