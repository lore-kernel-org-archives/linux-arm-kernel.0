From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 9 Jan 2017 11:30:04 +0100
Subject: [PATCH v2 02/12] driver: clocksource: add gpt timer for imx6sll
In-Reply-To: <1482832070-22668-3-git-send-email-ping.bai@nxp.com>
References: <1482832070-22668-1-git-send-email-ping.bai@nxp.com>
 <1482832070-22668-3-git-send-email-ping.bai@nxp.com>
Message-ID: <20170109103004.GA30688@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 05:47:40PM +0800, Bai Ping wrote:
> Add gpt timer support for i.MX6SLL.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  drivers/clocksource/timer-imx-gpt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
> index f595460..f71822d 100644
> --- a/drivers/clocksource/timer-imx-gpt.c
> +++ b/drivers/clocksource/timer-imx-gpt.c
> @@ -556,4 +556,5 @@ static int __init imx6dl_timer_init_dt(struct device_node *np)
>  CLOCKSOURCE_OF_DECLARE(imx6q_timer, "fsl,imx6q-gpt", imx31_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt", imx6dl_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx6sl_timer, "fsl,imx6sl-gpt", imx6dl_timer_init_dt);
> +CLOCKSOURCE_OF_DECLARE(imx6sll_timer, "fsl,imx6sll-gpt", imx6dl_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt", imx6dl_timer_init_dt);

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
