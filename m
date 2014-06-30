From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 30 Jun 2014 17:40:30 +0200
Subject: [GIT PULL] efm32 for 3.17-rc1
Message-ID: <20140630154030.GJ14781@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32-for-armsoc

for you to fetch changes up to f89056edb765268fe6880ab8caaee9331c3f5618:

  ARM: efm32: switch to vendor,device compatible strings (2014-06-30 17:11:53 +0200)

----------------------------------------------------------------
Just two follow-up changes for cleanups that went into v3.15-rc2.

----------------------------------------------------------------
These two patches were not sent to the list yet, but I will send them as
reply to this mail. If you prefer to pick them up by hand instead of
pulling, feel free to do so. I didn't put them into my for-next branch.

Best regards
Uwe

Uwe Kleine-K?nig (2):
      ARM: efm32: switch to properly namespaced location property
      ARM: efm32: switch to vendor,device compatible strings

 arch/arm/boot/dts/efm32gg-dk3750.dts |  6 +++---
 arch/arm/boot/dts/efm32gg.dtsi       | 32 ++++++++++++++++----------------
 2 files changed, 19 insertions(+), 19 deletions(-)


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
