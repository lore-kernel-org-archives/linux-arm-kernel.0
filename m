From: davidb@codeaurora.org (David Brown)
Date: Tue, 7 Sep 2010 16:31:19 -0700
Subject: [PATCH v2 1/2] msm: i2c: Add msm_qup_i2c.h
In-Reply-To: <1283471059-22262-2-git-send-email-kheitke@codeaurora.org>
References: <1283471059-22262-1-git-send-email-kheitke@codeaurora.org>
	<1283471059-22262-2-git-send-email-kheitke@codeaurora.org>
Message-ID: <20100907233119.GA2707@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 05:44:19PM -0600, Kenneth Heitke wrote:
> Defines the platform data used by the MSM QUP I2C driver.
> 
> Signed-off-by: Kenneth Heitke <kheitke@codeaurora.org>
> ---
>  arch/arm/mach-msm/include/mach/msm_qup_i2c.h |   28 ++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-msm/include/mach/msm_qup_i2c.h

Acked-by: David Brown <davidb@codeaurora.org>

It's probably easiest to just keep this patch together with the other
one, and bring them both into the I2C code together.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
