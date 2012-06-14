From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 14 Jun 2012 11:21:13 +0100
Subject: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
In-Reply-To: <20120614101819.GR30400@pengutronix.de>
References: <20120522234621.GA3610@windriver.com>
 <CAOh2x=mFOPKbzuY__k0RVpFHTdPfa-iN1e3Lpa3iWt9iP6FzFw@mail.gmail.com>
 <20120613221040.GJ30400@pengutronix.de>
 <20120614100425.GC28714@n2100.arm.linux.org.uk>
 <20120614101819.GR30400@pengutronix.de>
Message-ID: <CAOh2x=n64SMQ5OGkUC7NgMNCnRQYRgyc4mes4bDD0TUOMtn1BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 11:18 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Damn, you are right. I wasn't aware the netx has a AMBA cell and just
> grepped for netx in drivers/video.
> In this case I suggest to just return NULL for every clock.

And dropping fb's clk code would still be the right solution, as dummy
clk routines will
do that for you.

--
viresh
