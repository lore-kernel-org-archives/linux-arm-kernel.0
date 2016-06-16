From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 10:59:47 +0800
Subject: [GIT PULL] ARM: imx: fixes for 4.7
Message-ID: <20160616025945.GA29560@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.7

for you to fetch changes up to 20c15226d1c73150c4d9107301cac5dda0b7f995:

  ARM: imx6ul: Fix Micrel PHY mask (2016-06-09 20:49:29 +0800)

----------------------------------------------------------------
The i.MX fixes for 4.7:
 - Correct Micrel PHY mask to fix the issue that i.MX6UL ethernet works
   in U-Boot but not in kernel.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: imx6ul: Fix Micrel PHY mask

 arch/arm/mach-imx/mach-imx6ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
