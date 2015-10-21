From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 21 Oct 2015 18:08:56 +0800
Subject: [PATCH v2 3/4] clk: berlin: bg2q: remove CLK_IGNORE_UNUSED flag
 for sdio clk
In-Reply-To: <20151021095454.20687.98330@quantum>
References: <1445339807-2351-1-git-send-email-jszhang@marvell.com>
 <1445339807-2351-4-git-send-email-jszhang@marvell.com>
 <20151021093039.20687.88701@quantum>	<20151021095454.20687.98330@quantum>
Message-ID: <20151021180856.217e11ea@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Michael,

On Wed, 21 Oct 2015 02:54:54 -0700
Michael Turquette <mturquette@baylibre.com> wrote:

> Quoting Michael Turquette (2015-10-21 02:30:39)
> > Quoting Jisheng Zhang (2015-10-20 04:16:46)  
> > > Since we have added the necessary two clks' properties in dts, we can
> > > remove the "sdio" clk's CLK_IGNORE_UNUSED flag now.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>  
> > 
> > Applied to clk-next.  
> 
> So the sdhci change was dropped from v2. Do you want me to Ack these
> instead so you can send them all together?

I'll send another patch to for the sdhci change. it doesn't matter even the
sdhci change delay a merge window because no functionality changes in the
sdhci commit.

It's better we firstly take these clk clean ups because it saves power a bit
and clean up the CLK_IGNORE_UNUSED flag.

Hi Sebastian,

What do you think?

Thanks,
Jisheng
