From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 8 Dec 2011 16:03:48 +0100
Subject: ARM: at91: smc update
Message-ID: <20111208150348.GD23884@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	this patch series introduce new accessor to manipulate the smc
	and be allow to abstract it of the soc rm9200 vs sam9

The following changes since commit 5c4ee7a68bc518ec79ac04f7c3259899ecff61db:

  Merge branch 'next/cleanup' into for-next (2011-12-01 12:36:29 +0000)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git ..BRANCH.NOT.VERIFIED..

Jean-Christophe PLAGNIOL-VILLARD (3):
      ARM: at91: add accessor to manage smc
      pata/at91: use new introduce smc accessor
      ide/at91: use new introduce smc accessor

 arch/arm/mach-at91/include/mach/at91sam9_smc.h |   29 ++++++++
 arch/arm/mach-at91/sam9_smc.c                  |   93 ++++++++++++++++++++++--
 arch/arm/mach-at91/sam9_smc.h                  |   23 ------
 drivers/ata/pata_at91.c                        |   43 ++++++------
 drivers/ide/at91_ide.c                         |   65 ++++++++++-------
 5 files changed, 173 insertions(+), 80 deletions(-)

Best Regards,
J.
