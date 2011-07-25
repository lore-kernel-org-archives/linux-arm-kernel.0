From: davidb@codeaurora.org (David Brown)
Date: Mon, 25 Jul 2011 10:40:31 -0700
Subject: [PATCH v2] i2c: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <1308018114-19709-1-git-send-email-kheitke@codeaurora.org>
References: <1308018114-19709-1-git-send-email-kheitke@codeaurora.org>
Message-ID: <20110725174030.GA20835@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2011 at 08:21:53PM -0600, Kenneth Heitke wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm
> MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
> purpose data path engine with input/output FIFOs and an embedded i2c
> mini-core. The driver supports FIFO mode (for low bandwidth applications)
> and block mode (interrupt generated for each block-size data transfer).
> The driver currently does not support DMA transfers.
> 
> Signed-off-by: Kenneth Heitke <kheitke@codeaurora.org>

Ben, I was wondering if there were any outstanding issues with this
driver that Ken needs to address, or if it just got overlooked.

FWIW:
  Acked-By: David Brown <davidb@codeaurora.org>

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
