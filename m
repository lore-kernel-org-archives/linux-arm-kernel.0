From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 5 Jun 2017 23:11:59 +0200
Subject: [PATCH] arm: aspeed: Add clock-names property to timer node
In-Reply-To: <CACPK8XeM6fBztHwfrPUD+ewpMf==tBqgfj61B-k=SwT3ABTiZw@mail.gmail.com>
References: <20170605074846.30925-1-andrew@aj.id.au>
 <CACPK8XeM6fBztHwfrPUD+ewpMf==tBqgfj61B-k=SwT3ABTiZw@mail.gmail.com>
Message-ID: <20170605211159.GA2345@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 05, 2017 at 06:29:53PM +0930, Joel Stanley wrote:
> On Mon, Jun 5, 2017 at 5:18 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> > The merging of a number of clocksource drivers into fttmr010 means we
> > require clock-names to be specified in the Aspeed timer node, else the
> > clocksource fails to probe and boot hangs.
> 
> Arnd,
> 
> Linus' reworked timer driver will go into 4.13.
> 
> Can we get this patch merged into 4.12 as a fix so we don't end up
> with a broken boot at any stage?

I can take care of adding this patch in my branch before Linus' changes.

  -- Daniel
