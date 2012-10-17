From: tony@atomide.com (Tony Lindgren)
Date: Wed, 17 Oct 2012 16:50:46 -0700
Subject: Fwd: [PATCH 2/5] ARM: OMAP3+: hwmod: Add AM33XX HWMOD data for
 davinci_mdio
In-Reply-To: <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
References: <20121017181354.GA2412@netboy.at.omicron.at>
 <alpine.DEB.2.00.1210172337170.30902@utopia.booyaka.com>
Message-ID: <20121017235045.GB30550@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [121017 16:39]:
> Hi Richard
> 
> On Wed, 17 Oct 2012, Richard Cochran wrote:
> 
> > Would you please take this bugfix for 3.7-rc2? The suggestion to mail
> > you came from Toni Lindgren. The context where it came from is here:
> > 
> > http://lists.arm.linux.org.uk/lurker/message/20121015.191630.bdae3c50.en.html
> 
> This patch appears to add a new feature, correct?  I don't think the CPSW 
> could have worked in the past without this data present.  So it looks to 
> me like this is 3.8 material, unless Tony would like it to go in sooner?

Yeah unless it fixes something, we should just queue it for v3.8 merge
window.

Regards,

Tony
