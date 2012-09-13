From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Sep 2012 10:35:33 +0200
Subject: [GIT PULL 1/5] ARM i.MX board updates
In-Reply-To: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
References: <1347525337-19115-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1347525337-19115-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git tags/imx-boards

for you to fetch changes up to 688b5cbb81c1d5fc4aaaed47cde3f86fbb1472fe:

  ARM: mx27pdk: Add audio support (2012-08-03 15:59:29 +0200)

----------------------------------------------------------------
ARM i.MX board updates

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: mx27pdk: Add audio support

 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |   21 ++++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)
