From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  3 Jan 2018 13:57:17 +0800
Subject: [GIT PULL 2/5] i.MX SoC updates for 4.16
In-Reply-To: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
References: <1514959040-9992-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1514959040-9992-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 50c4c4e268a2d7a3e58ebb698ac74da0de40ae36:

  Linux 4.15-rc3 (2017-12-10 17:56:26 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.16

for you to fetch changes up to 5b2576ecf19418de699e230587a6d0b928a05e31:

  ARM: imx: remove unused imx3 pm definitions (2017-12-26 16:30:20 +0800)

----------------------------------------------------------------
i.MX SoC updates for 4.16:
 - Drop power saving status checking from MMDC driver probe function,
   since there is nothing really depending on power saving being
   enabled.
 - Clean up unused imx3 pm definitions.

----------------------------------------------------------------
Lucas Stach (1):
      ARM: imx: don't abort MMDC probe if power saving status doesn't match

Martin Kaiser (1):
      ARM: imx: remove unused imx3 pm definitions

 arch/arm/mach-imx/common.h |  9 ---------
 arch/arm/mach-imx/mmdc.c   | 11 -----------
 2 files changed, 20 deletions(-)
