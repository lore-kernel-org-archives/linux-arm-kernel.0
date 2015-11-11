From: tony@atomide.com (Tony Lindgren)
Date: Wed, 11 Nov 2015 14:45:27 -0800
Subject: [PATCH] ARM: OMAP: DRA7: hwmod: Add data for McASP3
In-Reply-To: <20151111214043.GI3218@atomide.com>
References: <1447261631-26362-1-git-send-email-balbi@ti.com>
 <56439641.6070901@ti.com>
 <alpine.DEB.2.02.1511112022100.24530@utopia.booyaka.com>
 <20151111214043.GI3218@atomide.com>
Message-ID: <20151111224526.GK3218@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151111 13:41]:
> * Paul Walmsley <paul@pwsan.com> [151111 12:23]:
> > On Wed, 11 Nov 2015, Peter Ujfalusi wrote:
> > 
> > > On 11/11/2015 07:07 PM, Felipe Balbi wrote:
> > > > From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > > 
> > > > McASP3 is used by default on DRA7x based boards for audio.
> > > 
> > > While this patch works, it is not the correct one(s) to apply.
> > > https://lkml.org/lkml/2015/10/30/91
> > > is the series which should have been applied to 4.4.
> > > Paul acked the series, but for some reason it missed the initial ARM pull for 4.4
> > 
> > It missed it because I was late getting my patches out for 4.4...
> 
> OK applying all three as fixes with your ack like you requested
> in the original thread.

Except one of them no longer applies cleanly against the current
mainline. So waiting until Peter rebases until applying anything.

Regards,

Tony
