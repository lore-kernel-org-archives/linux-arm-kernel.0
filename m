From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Mar 2012 11:38:29 +0100
Subject: [PATCH v6 3/3] clk: basic clock hardware types
In-Reply-To: <CAKGA1b=huAnG6tLoaGqoFoJnuEg-+rs8KLYVB1KF6_q73ot63A@mail.gmail.com>
References: <1331366064-1273-1-git-send-email-mturquette@linaro.org>
 <1331366064-1273-4-git-send-email-mturquette@linaro.org>
 <CAKGA1b=huAnG6tLoaGqoFoJnuEg-+rs8KLYVB1KF6_q73ot63A@mail.gmail.com>
Message-ID: <20120313103829.GR3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 10:50:09PM -0500, Matt Sealey wrote:
> Hi Mike,
> 
> Can I suggest/we discuss that we support fractional (i.e. represented
> by fixed point value with integer and fractional part) dividers in the
> common divider clock case, simplistically just adding a divider
> fractional width and shifting all the calculations by it (and fixing
> the "maxdiv" calculation as in a fractional case width of the divider
> area in the register is not an indicator of the actual maximum
> divider)? (I guess for the standard integer divider case, it would be
> continually shifting by 0 which might make the code a bit bigger, I
> don't think that would truly be a concern though?)

I have patches for this, see

git://git.pengutronix.de/git/imx/linux-2.6.git imx/work/imx-clkv6

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
