From: joel@jms.id.au (Joel Stanley)
Date: Wed, 18 Jan 2017 09:48:22 +1100
Subject: [GIT PULL] ARM: aspeed: soc for 4.11
Message-ID: <CACPK8XfSGGJq9M8D6yswBhFiX3tyNebx4MHY2a0Bxh_1icLDBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd and Olof,

Please pull the Aspeed soc tree for 4.11.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.11-soc

for you to fetch changes up to 43c08c1c1ae576a1517b31c9e3b615104c5ff131:

  ARM: aspeed: Select pinctrl drivers (2017-01-10 22:36:06 +1100)

----------------------------------------------------------------
Apseed SoC updates for 4.11

One commit that selects the newly upstreamed pinctrl driver for all
SoCs.

  ARM: aspeed: Select pinctrl drivers

----------------------------------------------------------------
Andrew Jeffery (1):
      ARM: aspeed: Select pinctrl drivers

 arch/arm/mach-aspeed/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)
