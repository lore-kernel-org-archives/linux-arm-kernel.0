From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 21 Aug 2013 02:53:12 +0000 (UTC)
Subject: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
In-Reply-To: <cover.1375443858.git.afzal@ti.com>
References: <cover.1375443858.git.afzal@ti.com>
Message-ID: <alpine.DEB.2.02.1308210249260.6426@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Fri, 2 Aug 2013, Afzal Mohammed wrote:

> AM43x PRCM support (excluding clock tree) is being added with this
> series. AM43x reuses most of the IP's from AM335x, as that is the
> case, much of the AM335x hwmod data is reused.

...

> Currently there is no public TRM available for AM43x.

Can you think of any way that the data can be doublechecked against some 
reference or against the reality of the chip?

Can development boards be made available to the OMAP maintainers so we can 
ensure that the code, once merged, continues to work?

> Powerdomain & Clockdomain data has been added separately as it was not
> giving much advantage reusing AM335x ones (runtime updates required
> was getting too ugly). But as AM43x PRCM functionality is similar to
> OMAP4, power domain, clock domain & hwmod operations are reused from
> OMAP4.

Is the AM43xx PRCM design and IP derived from AM33xx, or from OMAP4, or 
from something else?



- Paul
