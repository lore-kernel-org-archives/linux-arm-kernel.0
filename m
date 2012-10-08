From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Oct 2012 16:47:00 +0100
Subject: new branch for linux-next [Was: [PATCH v6 0/3] Updated
 Cortex-M3 series]
In-Reply-To: <20121008154325.GF18531@pengutronix.de>
References: <1343988614-5508-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20121008154325.GF18531@pengutronix.de>
Message-ID: <20121008154659.GY4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2012 at 05:43:25PM +0200, Uwe Kleine-K?nig wrote:
> Hello Stephen,
> 
> I already tried several times to get feedback from Russell King (as you
> probably know he's the ARM maintainer and busy most of the time) for my
> series to support Cortex-M3 machines. As I think the outcome will
> probably (at least) be that it should be included in next for some time
> first (as for example Arnd Bergmann already suggested), can you please
> add
> 
> 	git://git.pengutronix.de/git/ukl/linux-2.6.git for-next
> 
> to your tree? I'd suggest adding it after arm and arm-soc.
> I intend to use this branch later for efm32 support (which depends on
> the Cortex-M3 stuff).
> 
> Currently the branch is still empty, but I intend to fill it with what I
> consider to be applyable after I did some more testing. (Mainly to
> assert it still does what it did when I developed it on an older base.)
> 
> @Russell: I hope this is OK for you. If not, I'm sure you'll protest.

Well, I think the patches are mostly fine but I do think more eyes are
needed on them first.  I heard today that some people will be looking
at your Cortex M3 stuff, and hopefully that should move things forward.
