From: tony@atomide.com (Tony Lindgren)
Date: Wed, 29 Jun 2011 03:31:16 -0700
Subject: [RFC 1/2] omap: mcbsp: Drop SPI mode support
In-Reply-To: <6027329.5ZCJWRgjcM@barack>
References: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
	<6027329.5ZCJWRgjcM@barack>
Message-ID: <20110629103116.GC23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* P?ter Ujfalusi <peter.ujfalusi@ti.com> [110614 05:34]:
> On Tuesday 14 June 2011 13:23:51 Jarkko Nikula wrote:
> > We haven't seen any use for the SPI API in McBSP driver over the years. More
> > over, Peter Ujfalusi <peter.ujfalusi@ti.com> noticed that SPI mode is not
> > even supported since OMAP2430 so it's very unlikely that we'll see any use
> > for it in the future either.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> Either now or later, but for both:
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applying both of these into devel-cleanup branch.

Tony
