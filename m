From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 18 Feb 2014 10:31:31 +0100
Subject: [PATCH v2 10/23] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <20140217233855.GI7862@titan.lakedaemon.net>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-11-git-send-email-andrew@lunn.ch>
 <20140217233855.GI7862@titan.lakedaemon.net>
Message-ID: <20140218093131.GC17984@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +Required properties:
> > +- compatible : Should be either "marvell,ferocean-cache" or
> > +  	       "marvell,kirkwood-cache".
> > +
> > +Optional properties:
> > +- wt-override: If present then L2 is forced to Write through mode
> > +- reg        : Address of the L2 cache control register. Mandatory for
> > +  	       "marvell,kirkwood-cache", not used by "marvell,ferocean-cache"
> 
> s/ferocean/feroceon/

Arg. I thought i had fixed all of those.
 
> If there's nothing else deserving a new series, I'll tweak this (and the
> other spelling nits that matter) when I pull in the series.

This patch needs a major bit of re-working. There will definitely be a
new series.

    Andrew
