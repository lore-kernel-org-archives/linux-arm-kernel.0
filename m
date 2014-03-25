From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 26 Mar 2014 00:25:40 +0100
Subject: [PATCH 0/2] net: mvneta: fix usage as a module
Message-ID: <1395789942-20764-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

The following set of two patches fix the usage of the mvneta driver
when built as a module, and used in RGMII configurations. It is
somewhat similar to a previous fix that was made by Arnaud Patard, but
which was limited to SGMII configurations.

Thanks,

Thomas

Thomas Petazzoni (2):
  net: mvneta: rename MVNETA_GMAC2_PSC_ENABLE to MVNETA_GMAC2_PCS_ENABLE
  net: mvneta: fix usage as a module on RGMII configurations

 drivers/net/ethernet/marvell/mvneta.c | 43 ++++++++---------------------------
 1 file changed, 9 insertions(+), 34 deletions(-)

-- 
1.8.3.2
