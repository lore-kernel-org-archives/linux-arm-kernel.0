From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 25 Sep 2013 17:10:18 +0200
Subject: [PATCH v2 1/4] clockchips: Add FEAT_PERCPU clockevent flag
In-Reply-To: <1379530118-22813-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1379530118-22813-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379530118-22813-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5242FCDA.5020100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:48 PM, Soren Brinkmann wrote:
> Add the flag CLOCK_EVT_FEAT_PERCPU which is supposed to be set for per
> cpu clockevent devices.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  include/linux/clockchips.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/clockchips.h b/include/linux/clockchips.h
> index 0857922..493aa02 100644
> --- a/include/linux/clockchips.h
> +++ b/include/linux/clockchips.h
> @@ -60,6 +60,7 @@ enum clock_event_mode {
>   * Core shall set the interrupt affinity dynamically in broadcast mode
>   */
>  #define CLOCK_EVT_FEAT_DYNIRQ		0x000020
> +#define CLOCK_EVT_FEAT_PERCPU		0x000040
>  
>  /**
>   * struct clock_event_device - clock event device descriptor
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
