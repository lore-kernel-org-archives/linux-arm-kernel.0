From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  4 Mar 2014 10:48:50 -0800
Subject: [PATCH 0/2] pm8921 driver cleanup
Message-ID: <1393958932-3585-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two small cleanup patches for the pm8921 core driver.

Stephen Boyd (2):
  mfd: pm8921: Drop irq_set_lockdep_class() code
  mfd: pm8921: Use IRQCHIP_SKIP_SET_WAKE

 drivers/mfd/pm8921-core.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
