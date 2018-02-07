From: ping.bai@nxp.com (Jacky Bai)
Date: Wed, 7 Feb 2018 03:19:42 +0000
Subject: [PATCH v3 3/3] driver: clocksource: add gpt timer for imx6sll
In-Reply-To: <1517968181-12765-3-git-send-email-ping.bai@nxp.com>
References: <1517968181-12765-1-git-send-email-ping.bai@nxp.com>
 <1517968181-12765-3-git-send-email-ping.bai@nxp.com>
Message-ID: <HE1PR04MB3113FD502D4706CCAB691F9A87FC0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry. Please ignore this this three patches. Will resend the V4.

BR
Jacky Bai
> Subject: [PATCH v3 3/3] driver: clocksource: add gpt timer for imx6sll
> 
> Add gpt timer support for i.MX6SLL.
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
> change v1->v2:
>  - no
> change v2->v3:
>  - no
> ---
>  drivers/clocksource/timer-imx-gpt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-imx-gpt.c
> b/drivers/clocksource/timer-imx-gpt.c
> index 6ec6d79..ed19ce7 100644
> --- a/drivers/clocksource/timer-imx-gpt.c
> +++ b/drivers/clocksource/timer-imx-gpt.c
> @@ -557,3 +557,4 @@ static int __init imx6dl_timer_init_dt(struct
> device_node *np)  TIMER_OF_DECLARE(imx6dl_timer, "fsl,imx6dl-gpt",
> imx6dl_timer_init_dt);  TIMER_OF_DECLARE(imx6sl_timer, "fsl,imx6sl-gpt",
> imx6dl_timer_init_dt);  TIMER_OF_DECLARE(imx6sx_timer, "fsl,imx6sx-gpt",
> imx6dl_timer_init_dt);
> +TIMER_OF_DECLARE(imx6sl_timer, "fsl,imx6sll-gpt",
> +imx6dl_timer_init_dt);
> --
> 1.9.1
