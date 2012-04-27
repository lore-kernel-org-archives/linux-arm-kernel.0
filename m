From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 20:33:35 +0800
Subject: [PATCH 07/17] ARM: kirkwood: use machine specific hook for late
 init
In-Reply-To: <20120426193644.GA17250@lunn.ch>
References: <20120426193644.GA17250@lunn.ch>
Message-ID: <20120427123333.GW2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 09:36:44PM +0200, Andrew Lunn wrote:
> Hi Shawn
> 
> You can probably drop this patch. The move to common clock framework
> removes late_initcall(kirkwood_clock_gate). The common clock framework
> late init call is used instead to turn off all clocks which are no
> longer in use.

Ok, will drop the patch.

Regards,
Shawn

> 
> Take a look at:
> 
> https://lunn at github.com/lunn/orion-clk.git branch v3.4-rc4-clk-orion
> 
> I also have a version rebased on Mike clk-next tree, but i'm waiting
> for the discussion about what clk-next should be based on, before
> you again rebasing and posting my patches.
> 
> 	Andrew
