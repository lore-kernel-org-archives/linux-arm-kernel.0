From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 23 Dec 2013 11:37:27 -0800
Subject: [PATCH v3 00/13] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <52B838FD.4050809@elopez.com.ar>
References: <1387769564-12894-1-git-send-email-emilio@elopez.com.ar>
 <20131223054401.22761.10523@quantum> <52B838FD.4050809@elopez.com.ar>
Message-ID: <20131223193727.25490.76390@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-12-23 05:22:05)
> Hi Mike,
> 
> El 23/12/13 02:44, Mike Turquette escribi?:
> > Quoting Emilio L?pez (2013-12-22 19:32:31)
> >> Hi everyone,
> >>
> >> This is v3 of the sunxi clock series. For those seeing this for the
> >> first time, it adds PLL4, PLL5, PLL6 and mod0 clock support on sun4i, sun5i
> >> and sun7i. Additionally, mbus is supported on sun5i and sun7i. I would like
> >> to see this merged for 3.14 as clock users are progressing rapidly and will
> >> be needing this code, so all feedback is appreciated.
> >
> > For all the clock patches missing my Ack (I think just the first three):
> >
> > Acked-by: Mike Turquette <mturquette@linaro.org>
> 
> Great; if nobody else has any other objection I'd like to get these 
> merged for 3.14. I assume you'll want a pull request as agreed on 
> earlier; do you have a branch I can use as a base? These patches depend 
> on the pull Maxime sent last time and is currently sitting on clk-next.

I can assure you that 0903ea60, "clk: add accuracy support for fixed
clock" will not change, so feel free to base on that.

Also feel free to roll in "[PATCH 1/4] clk: sunxi: Allwinner A20 output
clock support" with your pull request if you like.

Regards,
Mike

> 
> Cheers!
> 
> Emilio
