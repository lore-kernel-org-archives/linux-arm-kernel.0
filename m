From: joel@jms.id.au (Joel Stanley)
Date: Wed, 18 Jul 2018 23:22:59 +0930
Subject: [PATCH 0/3] ARM: config: ASPEED and mutli v5 updates for 4.19
Message-ID: <20180718135302.4927-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some changes I will include in my pull request for 4.19.
The defconfigs are generated atop next-20180718.

Joel Stanley (3):
  ARM: config: aspeed: Update defconfig
  ARM: config: multi_v5: Refresh configuration
  ARM: config: multi_v5: Enable ASPEED drivers

 arch/arm/configs/aspeed_g4_defconfig | 94 +++++++++++++++++++++-----
 arch/arm/configs/aspeed_g5_defconfig | 98 ++++++++++++++++++++++------
 arch/arm/configs/multi_v5_defconfig  | 30 +++++----
 3 files changed, 175 insertions(+), 47 deletions(-)

-- 
2.17.1
