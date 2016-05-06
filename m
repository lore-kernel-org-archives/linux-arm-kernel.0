From: sricharan@codeaurora.org (Sricharan R)
Date: Fri,  6 May 2016 17:01:12 +0530
Subject: [PATCH V2 0/2] drivers: i2c: qup: Some misc fixes
Message-ID: <1462534274-28925-1-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One for fixing the bug with CONFIG_DEBUG_SG enabled and another
to suspend the transfer for all errors instead of just for nack.

Sricharan R (2):
  drivers: i2c: qup: Fix broken dma when CONFIG_DEBUG_SG is enabled.
  drivers: i2c: qup: Fix error handling

 drivers/i2c/busses/i2c-qup.c | 87 +++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 45 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
