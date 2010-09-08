From: tsoni@codeaurora.org (Trilok Soni)
Date: Wed, 08 Sep 2010 18:53:44 +0530
Subject: [PATCH v3] i2c: QUP based bus driver for Qualcomm MSM chipsets
In-Reply-To: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org>
References: <1283907557-1874-1-git-send-email-kheitke@codeaurora.org>
Message-ID: <4C878E60.3060000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2010 6:29 AM, Kenneth Heitke wrote:
> This bus driver supports the QUP i2c hardware controller in the Qualcomm
> MSM SOCs.  The Qualcomm Universal Peripheral Engine (QUP) is a general
> purpose data path engine with input/output FIFOs and an embedded i2c
> mini-core. The driver supports FIFO mode (for low bandwidth applications)
> and block mode (interrupt generated for each block-size data transfer).
> The driver currently does not support DMA transfers.
> 
> Signed-off-by: Kenneth Heitke <kheitke@codeaurora.org>
> ---
> v3: uses DIV_ROUND_UP() as recommended by linus.walleij at stericsson.com
> v2: incorporated feedback from the following people:
> 	ben-linux at fluff.org
> 	srinidhi.kasagar at stericsson.com
> 	tsoni at codeaurora.org

Looks good to me.

Acked-by: Trilok Soni <tsoni@codeaurora.org>

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
