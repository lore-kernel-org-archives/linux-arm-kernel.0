From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 23 May 2016 18:04:44 -0500
Subject: [PATCH] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <57438391.7090405@codeaurora.org>
References: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
 <20160523172527.GK4976@leverpostej>
 <f49d58ed-38b4-6284-11c2-8708d8443b14@codeaurora.org>
 <57438391.7090405@codeaurora.org>
Message-ID: <57438C8C.7050109@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christopher Covington wrote:
> They ended up calling the pinctrl file qcom/pinctrl/qdf2xxx.c.
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8f1338cd80648adf5434798f5393ad7c55d10848

To be fair, none of the other drivers in drivers/soc/ specify any 
specific SOCs.  They all have generic file names.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
