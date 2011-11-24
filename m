From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 24 Nov 2011 15:44:34 +0100
Subject: [AT91 PULL v2] defconfig pullrequest
Message-ID: <20111124144434.GL15531@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	this a split of the previous pull request that containt only the
	defconfig

	the gpio part will for 3.3

	this pull request will introduce a defconfig per soc with all machine
	enabled (today we can not compile multiple soc together we work on it)

	This will allow us to check that we break no board


	v2:

	update as suggest by Arnd

Please pull
The following changes since commit b4bbb02934e4511d9083f15c23e90703482e84ad:

  Revert "of/irq: of_irq_find_parent: check for parent equal to child" (2011-11-22 15:09:20 -0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.2-defconfig

Jean-Christophe PLAGNIOL-VILLARD (3):
      ARM: at91: rename defconfig files appropriately
      ARM: at91: refresh soc defconfig files for 3.2
      ARM: at91: enable additional boards in existing soc defconfig files

 .../{at91cap9adk_defconfig => at91cap9_defconfig}  |    7 ---
 arch/arm/configs/at91rm9200_defconfig              |   47 ++++++--------------
 ...91sam9260ek_defconfig => at91sam9260_defconfig} |   16 +++++--
 ...91sam9g20ek_defconfig => at91sam9g20_defconfig} |   23 +++++-----
 arch/arm/configs/at91sam9g45_defconfig             |    7 +--
 ...at91sam9rlek_defconfig => at91sam9rl_defconfig} |    5 --
 6 files changed, 40 insertions(+), 65 deletions(-)
 rename arch/arm/configs/{at91cap9adk_defconfig => at91cap9_defconfig} (93%)
 rename arch/arm/configs/{at91sam9260ek_defconfig => at91sam9260_defconfig} (86%)
 rename arch/arm/configs/{at91sam9g20ek_defconfig => at91sam9g20_defconfig} (90%)
 rename arch/arm/configs/{at91sam9rlek_defconfig => at91sam9rl_defconfig} (94%)

Best Regards,
J.
