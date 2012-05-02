From: mturquette@ti.com (Mike Turquette)
Date: Wed, 2 May 2012 12:19:38 -0700
Subject: [PATCH] clk: Use a separate struct for holding init data.
In-Reply-To: <20120502051633.GH15541@lunn.ch>
References: <4F9EE84C.90106@codeaurora.org>
 <CAJOA=zNCagT6GaeHi_jq7-LU9P-SfJZ8PA9bo-oeswjC0tHyYA@mail.gmail.com>
 <4F9F1659.1010804@codeaurora.org>
 <20120501081103.GC2194@S2101-09.ap.freescale.net>
 <20120501091334.GG15541@lunn.ch>
 <20120501170001.GB4089@opensource.wolfsonmicro.com>
 <4FA0258D.8020807@codeaurora.org>
 <20120501181922.GD4089@opensource.wolfsonmicro.com>
 <20120502015650.GE17311@gmail.com> <20120502051633.GH15541@lunn.ch>
Message-ID: <20120502191938.GA18180@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120502-07:16, Andrew Lunn wrote:
> > I could use some suggestions on the best way to resolve the merge issues
> > we have currently.  It appears that we have three bases that platforms
> > need to port over the common clk framework:
> > 
> > Russell's clkdev
> > Arnd's arm-soc
> > My clk-next branch
> 
> Hi Mike
> 
> The Orion code only depends on clk-next. I've been more conservative
> with the changes, knowing that once they are merged i can add more
> patches to make use of devm_get_clk() etc.
> 
> So for my, as well as going in via arm-soc, i could also imaging
> giving you a pull request and becoming part of clk-next. However, i
> don't care what route they take.
> 

Hi Andrew,

The choice is yours.

Regards,
Mike

>       Andrew
