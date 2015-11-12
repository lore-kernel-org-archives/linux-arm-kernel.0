From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 12 Nov 2015 07:29:45 -0600
Subject: [PATCH V4 1/4] dma: qcom_bam_dma: move to qcom directory
In-Reply-To: <1447310481-25463-2-git-send-email-okaya@codeaurora.org>
References: <1447310481-25463-1-git-send-email-okaya@codeaurora.org>
 <1447310481-25463-2-git-send-email-okaya@codeaurora.org>
Message-ID: <56449449.9050906@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sinan Kaya wrote:
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (c) 2013-2014, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.

I don't think this is appropriate.  You're not making any real changes 
to this driver, so you can't make any copyright claims about it.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
