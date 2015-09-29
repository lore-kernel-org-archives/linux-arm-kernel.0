From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 29 Sep 2015 20:10:01 +0200
Subject: [PULL] ARM: efm32: cleanups
Message-ID: <20150929181001.GF3982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:

  Linux 4.2 (2015-08-30 11:34:09 -0700)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32-for-4.4-rc1

for you to fetch changes up to f719a0d6a8541b383c506aaa4b4fa6b4109669f4:

  ARM: efm32: switch to vendor,device compatible strings (2015-09-10 10:02:38 +0200)

They are targeted for the next merge window and should not result in any
conflict.

----------------------------------------------------------------
efm32 cleanups for 4.4-rc1

These are just two followup cleanups for commits that are in v3.17-rc1 and
waited in my private tree for application since that time.

----------------------------------------------------------------
Uwe Kleine-K?nig (2):
      ARM: efm32: switch to properly namespaced location property
      ARM: efm32: switch to vendor,device compatible strings

 arch/arm/boot/dts/efm32gg-dk3750.dts |  8 ++++----
 arch/arm/boot/dts/efm32gg.dtsi       | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)
-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
