From: joel@jms.id.au (Joel Stanley)
Date: Thu, 24 Aug 2017 13:44:39 +0930
Subject: [GIT PULL] ARM: dts: aspeed: Changes for 4.14
Message-ID: <CACPK8XerZV+3RbxofpghWioYC68kK531aQQ_Jc8ZYLrjjCUqjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here's an Aspeed devicetree change for 4.14.

As with the defconfig pull, this change has been kicking around for a while
now so it is well tested.

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.14-devicetree

for you to fetch changes up to bcbd328d3fe765f333642b7cfe384d59dffc2db2:

  ARM: dts: aspeed-g4: fix AHB window size of the SMC controllers
(2017-08-23 16:06:02 +0930)

----------------------------------------------------------------
Aspeed devicetree updates for 4.14

 - fix to expose the full flash windows on ast2400.

----------------------------------------------------------------
C?dric Le Goater (1):
      ARM: dts: aspeed-g4: fix AHB window size of the SMC controllers

 arch/arm/boot/dts/aspeed-g4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
