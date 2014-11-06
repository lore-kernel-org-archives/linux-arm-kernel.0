From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 6 Nov 2014 11:00:06 -0600
Subject: [PATCH] soc: Include drivers/soc/Kconfig only once
In-Reply-To: <1415201542-29758-1-git-send-email-andreas@gaisler.com>
References: <1415201542-29758-1-git-send-email-andreas@gaisler.com>
Message-ID: <87C1AE4A-DCB4-4713-A731-AA81E1C920AA@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Kumar Gala <galak@codeaurora.org>

- k

On Nov 5, 2014, at 9:32 AM, Andreas Larsson <andreas@gaisler.com> wrote:

> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
> drivers/Kconfig |    2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 1a693d3..622fa26 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -148,8 +148,6 @@ source "drivers/remoteproc/Kconfig"
> 
> source "drivers/rpmsg/Kconfig"
> 
> -source "drivers/soc/Kconfig"
> -
> source "drivers/devfreq/Kconfig"
> 
> source "drivers/extcon/Kconfig"
> -- 
> 1.7.10.4
> 

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
