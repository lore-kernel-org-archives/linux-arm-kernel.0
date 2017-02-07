From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 07 Feb 2017 17:48:03 +0100
Subject: [PATCH 11/14] serial: 8250_dw: simplify optional reset handling
In-Reply-To: <CAHp75Vc1OZeGUJPMVROHhhN5WRtQ+9WT45txzKfm8bCdcN6TXg@mail.gmail.com>
References: <20170130114116.22089-1-p.zabel@pengutronix.de>
 <20170130114116.22089-11-p.zabel@pengutronix.de>
 <CAHp75Vc1OZeGUJPMVROHhhN5WRtQ+9WT45txzKfm8bCdcN6TXg@mail.gmail.com>
Message-ID: <1486486083.2277.83.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-03 at 00:21 +0200, Andy Shevchenko wrote:
> On Mon, Jan 30, 2017 at 1:41 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > As of commit bb475230b8e5 ("reset: make optional functions really
> > optional"), the reset framework API calls use NULL pointers to describe
> > optional, non-present reset controls.
> 
> Eventually!

That's fine, I'm going to wait for the above patch to hit mainline
before resending these patches anyway.

> FWIW:
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

regards
Philipp
