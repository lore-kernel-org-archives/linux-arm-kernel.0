From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 14 Jun 2012 10:36:29 +0300
Subject: [PATCH 00/11] ARM: OMAP: core/hwmod: first set of fixes for 3.5-rc
In-Reply-To: <alpine.DEB.2.00.1206131755130.30212@utopia.booyaka.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <1339162255.2091.56.camel@sokoban>
 <alpine.DEB.2.00.1206131755130.30212@utopia.booyaka.com>
Message-ID: <1339659389.2091.153.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-13 at 17:55 -0600, Paul Walmsley wrote:
> Hi Tero,
> 
> On Fri, 8 Jun 2012, Tero Kristo wrote:
> 
> > Tested this set on top of v3.5-rc1 with omap3 / omap4 suspend + my omap4
> > core retention / dev-off patches. There are a couple of minor issues,
> > like the bug in patch 5, and the fact that counter_32k hwmod data is
> > broken for omap4. This fix is needed on omap4 to fix the counter_32k, if
> > this is not done, device off does not work:
> 
> Thanks for the testing and the reminder.  Will send the next version of 
> this soon to address more comments from Tony.

I also tested the v2 with my last dev-off branch and it works perfectly
without any additional hwmod related tweaks.

-Tero
