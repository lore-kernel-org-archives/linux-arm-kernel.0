From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 8 Jun 2015 10:23:37 +0200
Subject: [PATCH v2 0/3] Fixes for at_xdmac
Message-ID: <1433751820-26142-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

I have updated patch 1 as you requested.

About patch 2, I don't really find how to split it. I have applied it on 4.0.4
without any conflicts so backport will not be an issue.


Changes from v1:
- remove indentation fixes from patch for stable and put it in another one.

Ludovic Desroches (3):
  dmaengine: at_xdmac: lock fixes
  dmaengine: at_xdmac: rework slave configuration part
  dmaengine: at_xdmac: fix indentation

 drivers/dma/at_xdmac.c | 241 +++++++++++++++++++++++++++++--------------------
 1 file changed, 144 insertions(+), 97 deletions(-)

-- 
2.2.0
