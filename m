From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 2 Nov 2011 16:58:03 +0100
Subject: [AT91 PULL] defconfig pullrequest
Message-ID: <20111102155803.GE7136@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	this a split of the previous pull request that containt only the
	defconfig

	the gpio part will for 3.3

	this pull request will introduce a defconfig per soc with all machine
	enabled (today we can not compile multiple soc together we work on it)

	This will allow us to check that we break no board

Please pull
The following changes since commit 5430cfc583fd8ec5e1bb2d211de29b23743122e4:

  at91: at91-ohci: configure overcurrent pins as input GPIOs (2011-09-07 17:15:19 +0200)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git j/for-arnd-defconfig

Jean-Christophe PLAGNIOL-VILLARD (4):
      ARM: at91: rename at91sam9rlek_defconfig to at91sam9rl_defconfig
      ARM: at91: rename at91cap9adk_defconfig to at91cap9_defconfig
      ARM: at91: rename at91sam9g20ek_defconfig to at91sam9g20_defconfig
      ARM: at91: rename at91sam9260ek_defconfig to at91sam9260_defconfig

 .../{at91cap9adk_defconfig => at91cap9_defconfig}  |    5 -----
 ...91sam9260ek_defconfig => at91sam9260_defconfig} |   14 ++++++++++----
 ...91sam9g20ek_defconfig => at91sam9g20_defconfig} |   19 ++++++++++---------
 ...at91sam9rlek_defconfig => at91sam9rl_defconfig} |    5 -----
 4 files changed, 20 insertions(+), 23 deletions(-)
 rename arch/arm/configs/{at91cap9adk_defconfig => at91cap9_defconfig} (95%)
 rename arch/arm/configs/{at91sam9260ek_defconfig => at91sam9260_defconfig} (89%)
 rename arch/arm/configs/{at91sam9g20ek_defconfig => at91sam9g20_defconfig} (93%)
 rename arch/arm/configs/{at91sam9rlek_defconfig => at91sam9rl_defconfig} (94%)

Best Regarfds,
J.
