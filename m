From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 19 Oct 2015 23:18:57 +0800
Subject: [GIT PULL 3/3] ARM: imx: defconfig updates for 4.4
In-Reply-To: <1445267937-2952-1-git-send-email-shawnguo@kernel.org>
References: <1445267937-2952-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1445267937-2952-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-defconfig-4.4

for you to fetch changes up to ed1098e4738d935cef12833b08916f6f5e700652:

  ARM: imx_v6_v7_defconfig: Remove CONFIG_VMSPLIT_2G (2015-09-23 05:19:37 -0700)

----------------------------------------------------------------
The i.MX defconfig updates for 4.4:
 - Enable i.MX6UL touchscreen controller support.
 - Remove CONFIG_VMSPLIT_2G option since we already enabled
   CONFIG_HIGHMEM support.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Remove CONFIG_VMSPLIT_2G

Haibo Chen (1):
      ARM: imx_v6_v7_defconfig: enable imx6ul_tsc

 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
