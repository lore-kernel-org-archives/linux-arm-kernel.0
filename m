From: agross@codeaurora.org (Andy Gross)
Date: Thu, 12 Feb 2015 10:15:41 -0600
Subject: [PATCH RESEND] dmaengine: qcom_bam_dma: Fix error path in probe
 function
In-Reply-To: <1423722101-16424-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1423722101-16424-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <20150212161541.GA25578@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 11:51:41AM +0530, Pramod Gurav wrote:
> Calls tasklet_kill() in error path of the probe function were missing.
> Add the same in error path.
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

Looks ok.

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
