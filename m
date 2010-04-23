From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 23 Apr 2010 09:40:24 +0200
Subject: i.MX35 Clock patches
Message-ID: <1272008426-14435-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some clock fixes for i.MX35.

Sascha

The following changes since commit 2ba3abd8186f24c7fb418927025b4e2120e3a362:
  Linus Torvalds (1):
        Merge branch 'pm-fixes' of git://git.kernel.org/.../rafael/suspend-2.6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git mxc-pu

Sascha Hauer (2):
      i.MX35: Fix arm/ahb clock calculation
      i.MX35: remove get_3_3_div helper function

 arch/arm/mach-mx3/clock-imx35.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)
