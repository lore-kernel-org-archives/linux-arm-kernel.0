From: davidb@codeaurora.org (David Brown)
Date: Tue, 20 Nov 2012 08:56:24 -0800
Subject: [PATCH 075/493] mfd: remove use of __devexit_p
In-Reply-To: <1353349642-3677-75-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-75-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120165624.GA21706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:20:24PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> 
> Cc: Peter Tyser <ptyser@xes-inc.com> 
> Cc: David Brown <davidb@codeaurora.org> 
> Cc: Daniel Walker <dwalker@fifo99.com> 
> Cc: Bryan Huntsman <bryanh@codeaurora.org> 
> Cc: linux-arm-kernel at lists.infradead.org 
> Cc: device-drivers-devel at blackfin.uclinux.org 
> Cc: patches at opensource.wolfsonmicro.com 
> Cc: linux-arm-msm at vger.kernel.org 
> ---
>  drivers/mfd/pm8921-core.c         | 2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
