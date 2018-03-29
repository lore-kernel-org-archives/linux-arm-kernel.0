From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Thu, 29 Mar 2018 18:12:20 +0800
Subject: [PATCH 0/2] net: mvneta: improve suspend/resume
Message-ID: <20180329181220.61d63c92@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series tries to optimize the mvneta's suspend/resume
implementation by only taking necessary actions.

Jisheng Zhang (2):
  net: mvneta: split rxq/txq init into SW and HW parts
  net: mvneta: improve suspend/resume

 drivers/net/ethernet/marvell/mvneta.c | 146 +++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 27 deletions(-)

-- 
2.16.3
