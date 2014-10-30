From: horms@verge.net.au (Simon Horman)
Date: Thu, 30 Oct 2014 16:20:19 +0900
Subject: [PATCH/RFC] ARM: shmobile: r8a7790: Add SDHI clock rate to
 device tree
In-Reply-To: <87ppdaxe3t.wl%kuninori.morimoto.gx@gmail.com>
References: <1414648643-30818-1-git-send-email-horms+renesas@verge.net.au>
 <87ppdaxe3t.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <20141030072017.GA17207@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 29, 2014 at 11:31:53PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > 
> > Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> > [simon: rebase]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> (snip)
> >  		reg = <0 0xee100000 0 0x200>;
> >  		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> >  		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> > +		renesas,clk-rate = <195000000>;
> >  		status = "disabled";
> >  	};
> 
> Unfortunately, this "renesas,clk-rate" is supporting
> only in Renesas BSP, not upstream.
> Same comment to r8a7791

Thanks, lets drop these patches.
