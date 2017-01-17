From: joel@jms.id.au (Joel Stanley)
Date: Wed, 18 Jan 2017 09:46:50 +1100
Subject: [GIT PULL] ARM: aspeed: defconfig for 4.11
Message-ID: <CACPK8XdfRoJjRX_txZjx2gxS4sqtUZNnUMvQS8Z=WXRQY3rKPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd and Olof,

Please pull the Aspeed defconfig tree for 4.11.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
tags/aspeed-4.11-defconfig

for you to fetch changes up to 0e81eb77f5f81be9a3fd4a080eba9abfb6e54a3a:

  ARM: configs: Update Aspeed with new drivers (2017-01-10 23:01:35 +1100)

----------------------------------------------------------------
Aspeed defconfig updates for 4.11

Just the one commit that updates our defconfigs with network (ftgmac100
and ncsi), bt ipmi, gpio and ncsi.

  ARM: configs: Update Aspeed with new drivers

----------------------------------------------------------------
Joel Stanley (1):
      ARM: configs: Update Aspeed with new drivers

 arch/arm/configs/aspeed_g4_defconfig | 38 ++++++++++++++++++++++++++++++++----
 arch/arm/configs/aspeed_g5_defconfig | 38 +++++++++++++++++++++++++++++++++++-
 2 files changed, 71 insertions(+), 5 deletions(-)
