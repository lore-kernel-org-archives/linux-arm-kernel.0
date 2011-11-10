From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 10 Nov 2011 16:18:28 +0800
Subject: [PATCH 1/9] ARM: mxc: time: convert to clk_prepare/clk_unprepare
In-Reply-To: <20111110080331.GS16886@pengutronix.de>
References: <1320900854-13031-1-git-send-email-richard.zhao@linaro.org>
 <20111110080331.GS16886@pengutronix.de>
Message-ID: <20111110081827.GA14234@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 09:03:31AM +0100, Sascha Hauer wrote:
> Hi Richard,
> 
> I think we should introduce two new helpers:
> 
> clk_prepare_enable()
> clk_disable_unprepare()
right. I will add two inline functions in include/linux/clk.h.
> 
> This series could look much nicer with it.
> 
> Minor nitpick: I don't like the subject. 'convert' suggests that you are
> replacing something, instead you are adding something.
It's copied from other commits doing the same thing. If you don't like it,
I can change it to "Add clk_prepare/clk_unprepare support".

For other driver patch doing the same thing, do you think you can handle it too, or let other
different driver maintainer handle it? If you can, I'll merge it into the same series.

Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
