From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Fri, 8 Jan 2010 16:32:05 -0600
Subject: [PATCH 0/5] V7/Cortex/omap34xx fixes for 2.6.33-rc1: DCC,
	kexec, atags
In-Reply-To: <alpine.DEB.2.00.1001051053000.2083@utopia.booyaka.com>
References: <20091219034151.26198.26570.stgit@localhost>
	<aec7e5c30912272155s41ce8914hd03a5e4c740a5b9d@mail.gmail.com>
	<20091229220705.GM3512@atomide.com>
	<alpine.DEB.2.00.1001051053000.2083@utopia.booyaka.com>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203A8571CA0@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Tuesday, January 05, 2010 11:54 AM

> > Also, what's the Cortex version on your v7? It's rev r2p3 on
> > omap3430.
>
> Just a quick note - I think it is r1p3 on OMAP34xx ES3.1 and below, and
> r1p7 on ES3.1.2.

Not quite accurate for the 'below' but as they are non-production they are not so impacting.

Current production CortexA8 chips for 3430:
        es3.2   :       r1p7
        es3.1   :       r1p3
        Earlier esX.Y used r0p0, r1p1, r1p2

Production candidate chips for 3630:
        es1.x   :       r3p2

Regards,
Richard W.
