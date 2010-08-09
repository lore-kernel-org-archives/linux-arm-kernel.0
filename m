From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  9 Aug 2010 14:38:12 +0300
Subject: [PATCH 0/2] mxc_nand: fixes for purposed updates
In-Reply-To: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <cover.1281353601.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With these patches applied I've tested mxc-nand-pu on a i.MX25 based system.

Baruch Siach (2):
  mxc_nand: fix build error
  mxc_nand: remove unused variables

 drivers/mtd/nand/mxc_nand.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)
