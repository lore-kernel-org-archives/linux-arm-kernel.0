From: stigge@antcom.de (Roland Stigge)
Date: Wed, 10 Sep 2014 15:51:33 +0200
Subject: [GIT PULL] ARM: LPC32xx: Device tree updates
In-Reply-To: <4173517.3fBhGIV2aO@wuerfel>
References: <540F1409.3070206@antcom.de> <4173517.3fBhGIV2aO@wuerfel>
Message-ID: <54105765.5090708@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 09/09/2014 05:43 PM, Arnd Bergmann wrote:
> I have no objection to the patches, but I notice that you have just
> rebased them all today on the latest -rc.
> In general, we prefer the branches to be based on an older -rc,
> preferably -rc1, unless you have a dependency on a bug fix that
> went into a later one.
> Can you rebase them to -rc1 and send a new version?

OK, sending.

> On a separate topic, are you still actively working with lpc32xx
> based machines?

I was so busy working with it that I didn't have the time to upstream
the few kernel changes to mainline... :-)

Will continue this in the future also.

> You cleaned up the platform a lot when you took
> over in 2012, but now we have move other platforms much further
> and I wonder if you could do some of the same changes.
> Most importantly, I really want most platforms to be part of
> ARCH_MULTIPLATFORM and build them into the same image. For
> lpc32xx, this is currently not possible because you are not using
> the common clk implementation. Would it be possible for you
> to look into converting that driver over and moving it to
> drivers/clk?

It's certainly possible, but time might be scarce. What would be a good
reference platform to have a look into as example? Or a hint/link?

Thanks in advance,

Roland
