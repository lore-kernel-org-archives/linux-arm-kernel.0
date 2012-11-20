From: davidb@codeaurora.org (David Brown)
Date: Tue, 20 Nov 2012 09:03:15 -0800
Subject: [PATCH 235/493] mfd: remove use of __devinit
In-Reply-To: <1353349642-3677-235-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-235-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120170315.GC21706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:23:04PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devinit is no longer
> needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/mfd/pm8921-core.c         |  4 ++--
>  drivers/mfd/pm8xxx-irq.c          |  2 +-
>  include/linux/mfd/pm8xxx/irq.h    |  4 ++--

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
