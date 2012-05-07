From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 May 2012 12:35:01 -0700
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120507191847.GJ5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <alpine.DEB.2.00.1205071259090.9984@utopia.booyaka.com>
 <20120507191847.GJ5088@atomide.com>
Message-ID: <20120507193500.GK5088@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [120507 12:22]:
> * Paul Walmsley <paul@pwsan.com> [120507 12:11]:
> > Hi,
> > 
> > On Fri, 4 May 2012, Tony Lindgren wrote:
> > 
> > > How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> > > Then this becomes just:
> > > 
> > > #ifdef CONFIG_SOC_OMAP3PLUS
> > 
> > We might want to consider having separate CONFIG_SOC_* values for each 
> > SoC.  So rather than CONFIG_SOC_OMAP3PLUS, we'd have CONFIG_SOC_OMAP3430, 
> > CONFIG_SOC_OMAP3630, etc.
> 
> Hmm but this would be in addition to the SOC specific options. The goal
> is to cut down the ifdeffery needed all over the place to add new SoCs,
> see the experimental patch I posted:
> 
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg67938.html

Of course we could make this finer grained based on features
like SOC_HAS_XYZ or SOC_HAS_OMAP3PLUS_PRMXYZBITS if you have some
grouping like that in mind.

Regards,

Tony
