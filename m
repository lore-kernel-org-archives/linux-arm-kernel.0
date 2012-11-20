From: davidb@codeaurora.org (David Brown)
Date: Tue, 20 Nov 2012 09:06:25 -0800
Subject: [PATCH 429/493] tty: remove use of __devexit
In-Reply-To: <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-429-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120170624.GF21706@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 01:26:18PM -0500, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> ---
>  drivers/tty/serial/msm_serial.c             |  2 +-
>  drivers/tty/serial/msm_serial_hs.c          |  2 +-

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
