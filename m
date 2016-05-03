From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  3 May 2016 23:58:06 +0800
Subject: [GIT PULL 6/6] Freescale/NXP arm64 defconfig updates for 4.7
In-Reply-To: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
References: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1462291086-19925-6-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

Different from above 5 pull requests that start off 4.6-rc1, this one
is based on 4.6-rc2, because commit 431597bb9556 ("arm64: defconfig:
updates for 4.6") changes arch/arm64/configs/defconfig dramatically
and went into 4.6-rc2.  I have to base my branch onto 4.6-rc2 to avoid
manual merging.

Please pull, thanks.

Shawn


The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig64-4.7

for you to fetch changes up to 3892132c2716e2747e562dd9a4c025387c19c329:

  arm64: defconfig: enable freescale/nxp config options (2016-04-27 10:12:34 +0800)

----------------------------------------------------------------
The arm64 defconfig update for Freescale/NXP support:
 - Clean up defconfig with savedefconfig
 - Enable 48-bit virtual address support
 - Enable driver support for various Freescale/NXP devices

----------------------------------------------------------------
Stuart Yoder (3):
      arm64: defconfig: cleanup the defconfig
      arm64: defconfig: enable 48-bit virtual addresses
      arm64: defconfig: enable freescale/nxp config options

 arch/arm64/configs/defconfig | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
