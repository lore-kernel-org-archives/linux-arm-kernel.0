From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jan 2012 15:20:43 +0000
Subject: [PATCH 0/6] ux500: Export SoC information and some platform
 clean-up
In-Reply-To: <4F2038E8.8090209@linaro.org>
References: <1327165687-4223-1-git-send-email-lee.jones@linaro.org>
 <201201251501.42304.arnd@arndb.de> <4F2038E8.8090209@linaro.org>
Message-ID: <201201261520.43176.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 25 January 2012, Lee Jones wrote:
> >>> Everyone else, who is planning to use the infrastructure besides ux500?
> >>
> >> I can easily see this being used in the ARM reference designs
> >> (Integrator, Versatile, RealView and Versatile Express) some of them
> >> I can possibly patch myself even. OMAP has expressed interest
> >> in "some way of getting the SoC ID out", and I guess this is
> >> the means to that end.
> > 
> > Ah, good. Once these patches are merged, we can easily refer anyone
> > to this infrastructure if they try to add a different way of finding
> > a SoC ID.
> 
> Okay, so this sounds promising. Which route are the patches likely to
> take? Will they go up through your SoC tree Arnd?

That's probably the best way. Of course you need to have Acks
from Greg (for the bus) and Linus Walleij (for the ux500 stuff)
before I can merge them. Linus can decide whether he wants to
submit them to me through a pull request from his ux500 tree
(with Signed-off-by) or whether I should apply them myself
(with Ack).

	Arnd
