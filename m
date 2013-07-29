From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Jul 2013 15:21:26 +0200
Subject: [PATCHv2 0/2] net: mvneta: big endian support
Message-ID: <1375104088-24654-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

You'll find in this patch series two small patches that add support
for big-endian in the mvneta driver, for the network interface found
in ARM Marvell Armada 370 and Armada XP SOCs. They are based on
3.11-rc3.

Changes since v1:
 * Rebased on top of 3.11-rc2.
 * Version sent once net-next is opened.

Thanks,

Thomas

Thomas Petazzoni (2):
  net: mvneta: move the RX and TX desc macros outside of the structs
  net: mvneta: support big endian

 drivers/net/ethernet/marvell/mvneta.c | 61 +++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 14 deletions(-)

-- 
1.8.1.2
