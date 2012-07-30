From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 07:53:36 +0100
Subject: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <20120729204218.GI4384@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
 <20120729204218.GI4384@opensource.wolfsonmicro.com>
Message-ID: <50162F70.2050900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/12 21:42, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 01:45:49PM +0100, Lee Jones wrote:
>
>> +	if (of_get_property(np, "stericsson,use-pinctrl", NULL))
>> +		msp->use_pinctrl = true;
>> +	else
>> +		msp->use_pinctrl = false;
>
> I don't recall seeing any response to my query about this on the first
> iteration.  Please don't just ignore review comments.

It wasn't intentional. I must have missed it before.

> This doesn't seem particularly sane...  why is this conditional?

It's conditional because only MSP1 and MSP3 have pinctrl support.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
