From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Nov 2016 11:43:32 +0100
Subject: [PATCH 0/2] replace IS_ERR_OR_NULL by IS_ERR
Message-ID: <1479293014-18811-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace IS_ERR_OR_NULL by IS_ERR on knav_queue_open calls.

---

 drivers/net/ethernet/ti/netcp_core.c |    6 +++---
 drivers/soc/ti/knav_qmss_queue.c     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
