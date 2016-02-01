From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 1 Feb 2016 10:46:58 -0500
Subject: [PATCH V13 08/10] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <20160201153542.GA20396@leverpostej>
References: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
 <1454106914-15857-9-git-send-email-okaya@codeaurora.org>
 <20160201153542.GA20396@leverpostej>
Message-ID: <56AF7DF2.9020202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/2016 10:35 AM, Mark Rutland wrote:
> Fold this in to the patches adding the binding and the driver.
> 
> There is no reason to add this then remove it within the same series.
> 
> Mark.

Will do. I was trying to keep changes to the minimum on the other patches to 
help the reviewers.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
