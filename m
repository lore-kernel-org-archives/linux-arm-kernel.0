From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 07 Jun 2010 09:30:36 +0200
Subject: [PATCH v2 5/5] input: samsung-keypad - Add samsung keypad driver
In-Reply-To: <20100603010025.GA14272@trinity.fluff.org>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
	<1275188784-23395-5-git-send-email-jy0922.shim@samsung.com>
	<20100530034250.GK7248@trinity.fluff.org>
	<4C01EB2E.4020600@samsung.com>
	<20100603010025.GA14272@trinity.fluff.org>
Message-ID: <000b01cb0613$5545bc90$ffd135b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, June 03, 2010 3:00 AM Ben Dooks wrote:

> > >> +	keypad->clk = clk_get(&pdev->dev, "keypad");
> 
> I'm going to get rid of this practice, it should be clk_get(&pdev->dev,
> NULL),
> see up-comming clock changes.

Good idea, but how do you want to handle some special/additional clocks?
Like for example mmc_bus or fimc_sclk clocks?

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
