From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 28 Apr 2014 12:25:10 -0300
Subject: [PATCH 5/7] clk: sunxi: add PRCM (Power/Reset/Clock Management)
 clks support
In-Reply-To: <1398697130-8338-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
 <1398697130-8338-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <535E72D6.6060206@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

El 28/04/14 11:58, Boris BREZILLON escribi?:
> The PRCM (Power/Reset/Clock Management) unit provides several clock
> devices:
> - AR100 clk: used to clock the Power Management co-processor
> - AHB0 clk: used to clock the AHB0 bus
> - APB0 clk and gates: used to clk
>
> Add support for these clks in a separate driver so that they can be probed
> as platform devices instead of registered during early init.
> We need this to be able to probe PRCM MFD subdevices.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
(..)
> +
> +MODULE_AUTHOR("Boris BREZILLON <boris.brezillon@free-electrons.com");

There's a missing >

> +MODULE_DESCRIPTION("Allwinner Reset Controller Driver");

Copy/paste leftover?

> +MODULE_LICENSE("GPL v2");

I just skimmed through this now, I'll have a more detailed look later. 
Thanks for working on sun6i support :)

Cheers,

Emilio
