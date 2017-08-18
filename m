From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 18 Aug 2017 16:05:47 +0800
Subject: [GIT PULL 1/3] ZTE SoC updates for 4.14
Message-ID: <1503043549-13232-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-soc-4.14

for you to fetch changes up to 03d95c264a0277418e21cbb9043c12bf0604be05:

  arm64: select PINCTRL for ZTE platform (2017-08-14 09:50:24 +0800)

----------------------------------------------------------------
ZTE SoC updates for 4.14:
 - Select PINCTRL for ZTE platform, so that pinctrl driver for ZX296718
   can be enabled.

----------------------------------------------------------------
Shawn Guo (1):
      arm64: select PINCTRL for ZTE platform

 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)
