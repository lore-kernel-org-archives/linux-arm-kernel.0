From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Mar 2012 11:02:15 -0700 (MST)
Subject: [PATCH] ARM: OMAP4: clock: Add aliases for McBSP fclk clocks
In-Reply-To: <20120309180027.GF12083@atomide.com>
References: <1331024133-18201-1-git-send-email-peter.ujfalusi@ti.com>
 <4F5A258F.8050704@ti.com> <20120309180027.GF12083@atomide.com>
Message-ID: <alpine.DEB.2.00.1203091101400.7039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 9 Mar 2012, Tony Lindgren wrote:

> * Peter Ujfalusi <peter.ujfalusi@ti.com> [120309 07:47]:
> > Hi Paul, Tony,
> > 
> > On 03/06/2012 10:55 AM, Peter Ujfalusi wrote:
> > > CLKS signal for McBSP ports can be selected from internal (PRCM) or external
> > > (ABE_CLKS pin) source.
> > > To be able to use existing code we need to create clock aliases consistent
> > > among OMAP2/3/4.
> > 
> > Would you be able to take a look at this patch?
> 
> To me this looks safe to merge via ASoC tree, assuming Paul
> acks it too, and it does not cause merge conflicts with
> Paul's changes:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Please let's not merge this one yet.  It should not be necessary to change 
the clkdev aliases, this change should occur in the hwmod code.


- Paul
