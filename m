From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 30 Jul 2012 14:39:30 +0100
Subject: [PATCH 05/18] ASoC: Ux500: Enable ux500 MSP driver for Device Tree
In-Reply-To: <50162F70.2050900@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-6-git-send-email-lee.jones@linaro.org>
 <20120729204218.GI4384@opensource.wolfsonmicro.com>
 <50162F70.2050900@linaro.org>
Message-ID: <20120730133930.GB4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 07:53:36AM +0100, Lee Jones wrote:
> On 29/07/12 21:42, Mark Brown wrote:

> >>+	if (of_get_property(np, "stericsson,use-pinctrl", NULL))

> >This doesn't seem particularly sane...  why is this conditional?

> It's conditional because only MSP1 and MSP3 have pinctrl support.

Why does the driver care - doesn't the pinctrl abstraction and/or
bindings handle this sensibly?
