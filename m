From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 19 Mar 2014 10:00:07 +0100
Subject: [GIT PULL, RESEND] Reset controller fixes and updates
Message-ID: <1395219607.4300.14.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/pza/linux.git reset/for_v3.15

for you to fetch changes up to b424080a9e086e683ad5fdc624a7cf3c024e0c0f:

  reset: Add optional resets and stubs (2014-03-09 19:53:45 +0100)

regards
Philipp

----------------------------------------------------------------
Maxime Ripard (1):
      reset: Add of_reset_control_get

Philipp Zabel (2):
      reset: allow drivers to request probe deferral
      reset: Add optional resets and stubs

Rashika Kheria (1):
      reset: Mark function as static and remove unused function in core.c

 drivers/reset/core.c  | 71 +++++++++++++++++++++++----------------------------
 include/linux/reset.h | 65 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 96 insertions(+), 40 deletions(-)
