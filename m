From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Tue, 16 Nov 2010 01:25:33 -0800 (PST)
Subject: [PATCH] mx35_3ds: Add watchdog support
In-Reply-To: <20101116063818.GR8942@pengutronix.de>
Message-ID: <105118.89235.qm@web51004.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe and Wolfram,

--- On Tue, 11/16/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
...
> 
> I wonder why the driver uses clk_get_sys("imx-wdt.0",
> NULL).
> IMHO it should use clk_get(&pdev->dev, NULL).?
> (For that to work we need
> to register the clock using "imx2-wdt.0".? (Or even
> better "imx2-wdt".))

I sent a patch for registering a dummy watchdog clock: http://www.spinics.net/lists/arm-kernel/msg104087.html

This way we don?t need to change the watchdog driver.

Let me know what you think. 

Regards,

Fabio Estevam



      
