From: joe@perches.com (Joe Perches)
Date: Wed, 06 May 2015 00:44:59 -0700
Subject: [PATCH v4 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <1430897022-63357-3-git-send-email-eddie.huang@mediatek.com>
References: <1430897022-63357-1-git-send-email-eddie.huang@mediatek.com>
 <1430897022-63357-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1430898299.9365.74.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-06 at 15:23 +0800, Eddie Huang wrote:
> From: Tianping Fang <tianping.fang@mediatek.com>

trivia: no need to resend now, maybe in a future patch.

> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
[]
> +static int mtk_rtc_probe(struct platform_device *pdev)
> +{
[]
> +	ret = request_threaded_irq(rtc->irq, NULL,
> +				   mtk_rtc_irq_handler_thread,
> +				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +			"mt6397-rtc", rtc);

It'd be nicer to align all the statement lines
to that open parenthesis
