From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jul 2013 15:27:24 +0200
Subject: [PATCH 0/2] net: mvneta: big endian support
Message-ID: <1373894846-1147-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

You'll find in this patch series two small patches that add support
for big-endian in the mvneta driver, for the network interface found
in ARM Marvell Armada 370 and Armada XP SOCs. They are based on
3.11-rc1.

Thanks,

Thomas

Thomas Petazzoni (2):
  net: mvneta: move the RX and TX desc macros outside of the structs
  net: mvneta: support big endian

 drivers/net/ethernet/marvell/mvneta.c | 61 +++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 14 deletions(-)

-- 
1.8.1.2
