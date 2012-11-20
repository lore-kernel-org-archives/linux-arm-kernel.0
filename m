From: davidb@codeaurora.org (David Brown)
Date: Tue, 20 Nov 2012 08:57:26 -0800
Subject: [PATCH 158/493] video: remove use of __devinit
In-Reply-To: <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-158-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120165726.GB21706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:21:47PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/video/msm/mddi.c                           |  6 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
