From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 19 Dec 2017 17:59:44 +0100
Subject: [PATCH net 0/3] Few mvneta fixes
Message-ID: <20171219165947.28516-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here it is a small series of fixes found on the mvneta driver. They
had been already used in the vendor kernel and are now ported to
mainline.

Thanks,

Gregory

Yelena Krivosheev (3):
  net: mvneta: clear interface link status on port disable
  net: mvneta: use proper rxq_number in loop on rx queues
  net: mvneta: eliminate wrong call to handle rx descriptor error

 drivers/net/ethernet/marvell/mvneta.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.15.1
