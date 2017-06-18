From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 18 Jun 2017 23:55:20 +0800
Subject: [GIT PULL 2/5] i.MX SoC updates for 4.13
In-Reply-To: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
References: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1497801323-6389-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.13

for you to fetch changes up to bf5a01d7c50fb0c4e1c3d320d670bad252d50bcb:

  ARM: imx6ull: Make suspend/resume work like on 6ul (2017-06-07 11:38:40 +0800)

----------------------------------------------------------------
The i.MX SoC updates for 4.13:
 - Select GPCv2 for i.MX7 SoCs to get imx-gpcv2 irqchip driver built
   for i.MX7 platforms by default.
 - A couple of patches from Leonard to add IMX6ULL cpu check and get
   suspend/resume work on IMX6ULL.

----------------------------------------------------------------
Andrey Smirnov (1):
      ARM: imx: Select GPCv2 for i.MX7

Leonard Crestez (2):
      ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
      ARM: imx6ull: Make suspend/resume work like on 6ul

 arch/arm/mach-imx/Kconfig   | 1 +
 arch/arm/mach-imx/cpu.c     | 3 +++
 arch/arm/mach-imx/mxc.h     | 6 ++++++
 arch/arm/mach-imx/pm-imx6.c | 6 ++++--
 4 files changed, 14 insertions(+), 2 deletions(-)
