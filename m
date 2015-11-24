From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Nov 2015 13:00:45 -0800
Subject: [PATCH RFC 17/27] drivers: cpu-pd: Record CPUs that are part of
 the domain
In-Reply-To: <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-18-git-send-email-lina.iyer@linaro.org>
Message-ID: <20151124210043.GD25963@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17, Lina Iyer wrote:
> diff --git a/drivers/base/power/cpu-pd.c b/drivers/base/power/cpu-pd.c
> index 9758b8d..617ce54 100644
> --- a/drivers/base/power/cpu-pd.c
> +++ b/drivers/base/power/cpu-pd.c
> @@ -18,6 +18,7 @@
>  #include <linux/device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_qos.h>

What's this added for?

>  #include <linux/rculist.h>
>  #include <linux/slab.h>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
