From: timur@codeaurora.org (Timur Tabi)
Date: Sun, 31 Jul 2016 09:14:30 -0500
Subject: [PATCH V2] dmaengine: qcom_hidma: release the descriptor before
 the callback
In-Reply-To: <579E079C.2040500@codeaurora.org>
References: <1469974266-28023-1-git-send-email-okaya@codeaurora.org>
 <579E079C.2040500@codeaurora.org>
Message-ID: <579E07C6.5080508@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timur Tabi wrote:
>>
>
> It looks to me like 'callback' and 'param' are never actually used.

Never mind.  I really shouldn't review code before my morning coffee.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
