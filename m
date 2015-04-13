From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Apr 2015 11:53:06 +0200
Subject: [PATCH 4/6] clk: mediatek: Add basic clocks for Mediatek MT8135.
In-Reply-To: <CABuKBeJKrDMR+xHSk_WvppGE7KftMy-QL8ATFi081++C3vaKEg@mail.gmail.com>
References: <1427825817-26773-1-git-send-email-s.hauer@pengutronix.de>
 <1427825817-26773-5-git-send-email-s.hauer@pengutronix.de>
 <CABuKBeJKrDMR+xHSk_WvppGE7KftMy-QL8ATFi081++C3vaKEg@mail.gmail.com>
Message-ID: <20150413095306.GM9742@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 07:05:22PM +0200, Matthias Brugger wrote:
> 2015-03-31 20:16 GMT+02:00 Sascha Hauer <s.hauer@pengutronix.de>:
> > +
> > +       FACTOR(TOP_UNIVPLL_D3, "univpll_d3", "univpll_416m", 1, 1),
> > +       FACTOR(TOP_UNIVPLL_D5, "univpll_d5", "univpll_249p6m", 1, 1),
> > +       FACTOR(TOP_UNIVPLL_D7, "univpll_d7", "univpll_178p3m", 1, 1),
> > +       FACTOR(TOP_UNIVPLL_D10, "univpll_d10", "univpll_249p6m", 1, 5),
> 
> shouldn't that be
> FACTOR(TOP_UNIVPLL_D10, "univpll_d10", "univpll_249p6m", 1, 2),
> as univpll_249p6m is univpll divided by 5?

Yes, fixed.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
