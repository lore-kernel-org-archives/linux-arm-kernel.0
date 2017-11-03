From: jackp@codeaurora.org (Jack Pham)
Date: Thu, 2 Nov 2017 17:02:58 -0700
Subject: [PATCH v3 2/3] usb: phy: remove phy-msm-usb.c
In-Reply-To: <20171031131131.8099-3-elder@linaro.org>
References: <20171031131131.8099-1-elder@linaro.org>
 <20171031131131.8099-3-elder@linaro.org>
Message-ID: <20171103000257.GG12812@usblab-sd-06.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Tue, Oct 31, 2017 at 08:11:30AM -0500, Alex Elder wrote:
> No Qualcomm SoC requires the "phy-msm-usb.c" USB phy driver support
> any more, so remove the code.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Alex Elder <elder@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Acked-by: Andy Gross <andy.gross@linaro.org>
> ---
<snip>

> -#include <linux/usb/msm_hsusb_hw.h>

This file and ehci-msm.c were the last consumers of this header, so it
too can now be deleted. Has your series been picked up yet? If so I or
someone can send a follow-up patch.

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
