From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Fri, 11 Apr 2014 19:39:06 +0300
Subject: [GIT PULL] remoteproc cleanups for 3.15
Message-ID: <CAK=WgbYgnu38wGr3gGg_k5ULguQHYPitJyoyb-QO0z3CwCrAUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ohad/remoteproc.git
tags/remoteproc-3.15-cleanups

for you to fetch changes up to bd88acba5f9809af48f66267bb16024b9e33cf2b:

  remoteproc/ste_modem: staticize local symbols (2014-02-24 11:16:16 +0200)

----------------------------------------------------------------
Several remoteproc cleanup patches coming from Jingoo Han, Julia
Lawall and Uwe Kleine-K?nig.

----------------------------------------------------------------
Jingoo Han (1):
      remoteproc/ste_modem: staticize local symbols

Julia Lawall (1):
      remoteproc/davinci: simplify use of devm_ioremap_resource

Uwe Kleine-K?nig (1):
      remoteproc/davinci: drop needless devm_clk_put

 drivers/remoteproc/da8xx_remoteproc.c | 16 +---------------
 drivers/remoteproc/ste_modem_rproc.c  |  4 ++--
 2 files changed, 3 insertions(+), 17 deletions(-)
