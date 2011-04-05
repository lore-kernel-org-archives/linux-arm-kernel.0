From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Apr 2011 12:54:47 +0300
Subject: [PATCH] arm: omap: introduce OMAP MCOP board file
In-Reply-To: <20110405095119.GD4699@n2100.arm.linux.org.uk>
References: <1301995970-23699-1-git-send-email-balbi@ti.com>
	<20110405093656.GS2176@legolas.emea.dhcp.ti.com>
	<20110405095119.GD4699@n2100.arm.linux.org.uk>
Message-ID: <20110405095446.GF23776@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 05, 2011 at 10:51:19AM +0100, Russell King - ARM Linux wrote:
> > I don't think Linus will like if we add yet another hwmod + clk data
> > file just for MCOP, so we need to re-use what's in tree.
> 
> I'd suggest holding fire on new stuff.
> 
> We *absolutely* *must* show that we're taking Linus' complaint seriously
> and make headway towards consolidating some of the code.  I don't see that
> activity as optional.
> 
> I've now made the decision (as I mentioned I may do in the thread) that
> for the next merge window I'm only taking consolidations and bug fixes
> through my tree, and I encourage everyone else to do the same.  At the
> moment, I'm planning for this up until the next merge window, but if
> sufficient progress hasn't been done, I'll extend it thereafter.
> 
> In other words, no new platform code and no new platform class code.
> 
> The longer it takes to get the consolidation effort producing results, the
> longer we will have to keep the restriction in place, and the more painful
> it'll be for people who want to have their platforms merged.
> 
> So I hope *no* one is thinking "this isn't my problem, someone else will
> solve it" - if you're thinking that then we're doomed.

Ok Russell, we will hold on to this patch and try to help as we can on
the code consolidation effort.

Let's hope to get this sorted out soon as it would be really great for
us to start pre-silicon validation with mainline kernel with little to
no effort needed :-D

-- 
balbi
