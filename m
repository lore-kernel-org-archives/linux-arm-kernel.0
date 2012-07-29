From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 29 Jul 2012 21:42:18 +0100
Subject: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20120729204218.GI4384@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 01:45:49PM +0100, Lee Jones wrote:

> +	if (of_get_property(np, "stericsson,use-pinctrl", NULL))
> +		msp->use_pinctrl = true;
> +	else
> +		msp->use_pinctrl = false;

I don't recall seeing any response to my query about this on the first
iteration.  Please don't just ignore review comments.
