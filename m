From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 18 Jun 2017 23:55:19 +0800
Subject: [GIT PULL 1/5] i.MX driver changes for 4.13
Message-ID: <1497801323-6389-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.13

for you to fetch changes up to c465a32fdde67c029ba8880f2878491042b72524:

  soc: imx: gpc: build gpc only if hardware has gpc (2017-05-15 10:22:25 +0800)

----------------------------------------------------------------
The i.MX drivers update for 4.13:
 - Add CONFIG_HAVE_IMX_GPC to control the build of GPC driver, so that
   it doesn't build for platforms that do not have it.

----------------------------------------------------------------
Marc Ohlf (1):
      soc: imx: gpc: build gpc only if hardware has gpc

 drivers/soc/imx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
