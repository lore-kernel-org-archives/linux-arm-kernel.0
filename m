From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Jul 2011 16:16:12 +0300
Subject: [PATCH v2 00/18] OMAP4: PM data big spring cleanup and fixes
In-Reply-To: <alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107060017480.4217@utopia.booyaka.com>
	<4E14B820.6070202@ti.com> <20110707055549.GC15815@atomide.com>
	<alpine.DEB.2.00.1107080031440.24181@utopia.booyaka.com>
Message-ID: <20110708131611.GE11037@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [110708 09:34]:
> On Thu, 7 Jul 2011, Tony Lindgren wrote:
> 
> Rajendra's patch series doesn't require the 4430 -> 44XX changes in the 
> PRM/CM macros (Beno?t's patch 16).  That patch can be put in a separate 
> series, if you like.  
> 
> It does require changing CHIP_IS_OMAP4430 to CHIP_IS_OMAP44XX in the 
> powerdomains, clockdomains, etc.  To me, that seems reasonable since the 
> 4460 isn't simply a die shrink, it has some other changes on it; but I 
> guess you have a different view on that.

To me it seems the CHIP_IS_OMAP44XX is just defined as CHIP_IS_OMAP3430
in Benoit's patch 16.

> I will add acks/reviewed-by:s on the 4460 patches, and maybe you can 
> decide which ones you'd like to merge, if any.

I applied the first four 4460 patches but left out the CHIP_IS44XX
changes.

Regards,

Tony
