From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 15 Jan 2014 00:45:31 +0100
Subject: [PATCH net-next 0/2] net: mvneta: simple cleanups
Message-ID: <cover.1389742334.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Those two patches are intended for net-next. They apply on top of
performance improvements patches from Willy for mvneta driver.
They provide some simple cleanups for unused variables, function
params or return values.

Arnaud Ebalard (2):
  net: mvneta: mvneta_tx_done_gbe() cleanups
  net: mvneta: make mvneta_txq_done() return void

 drivers/net/ethernet/marvell/mvneta.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

-- 
1.8.5.2
