From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Fri, 15 Aug 2014 18:54:37 +0200
Subject: [PATCHv10 2/2] arm: dts: Add Altera SDRAM EDAC bindings &
 devicetree entries.
In-Reply-To: <53EE398D.3060509@opensource.altera.com>
References: <1407770293-27190-1-git-send-email-tthayer@opensource.altera.com>
 <1407770293-27190-3-git-send-email-tthayer@opensource.altera.com>
 <73vbputf04.fsf@dude.hi.pengutronix.de>
 <alpine.DEB.2.02.1408151035110.21645@atx-linux-37>
 <53EE398D.3060509@opensource.altera.com>
Message-ID: <20140815165437.GB19071@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 11:47:09AM -0500, Thor Thayer wrote:
> Hi Steffen!
> 
> Building on Alan's points, I don't see the reference to the child
> nodes in the syscon.txt binding documentation - can you point out
> what I'm missing?
> 
> I based this patch on other examples of syscon, and there aren't
> child nodes (exynos5250.dtsi, omap3.dtsi, etc). According to my
> understanding of the device tree parsing, the parent needs to
> register child nodes. Since syscon is the parent and doesn't
> register the child nodes, they won't be automatically probed. The
> other syscon implementations are at the same level as the syscon and
> use a phandle to the syscon (for instance the omap3.dtsi).
> 
> Thanks for reviewing!
> 
> Thor

Hm, I looked in one of my many directories with some version of the
kernel tree checked out, but ... you are right.
I can't find where I read that. Seems like I got confused somewhere...
There is now version of syscon.txt that mentions anything about childs.

Should have drank my morning coffee first.

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
