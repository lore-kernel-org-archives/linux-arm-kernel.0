From: broonie@kernel.org (Mark Brown)
Date: Fri, 1 Jul 2016 11:59:43 +0200
Subject: [PATCH 6/6] spi: st-ssc4: Remove 'no clocking' hack
In-Reply-To: <20160630205215.GF1707@dell>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160607111930.10375-7-lee.jones@linaro.org>
 <20160607151712.GA7510@sirena.org.uk> <20160630205215.GF1707@dell>
Message-ID: <20160701095943.GL6247@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 09:52:15PM +0100, Lee Jones wrote:
> On Tue, 07 Jun 2016, Mark Brown wrote:
> > On Tue, Jun 07, 2016 at 12:19:30PM +0100, Lee Jones wrote:
> > > Due to the newly upstreamed 'critical clocks' API we can now
> > > safely handle clocking in the SPI and I2C drivers without fear
> > > of catastrophically crippling the running platform.

> > Acked-by: Mark Brown <broonie@kernel.org>

> We really need to guarantee that this goes in *after* the other
> patches have landed, and it looks like they're heading in via their
> own respective trees.  Any chance you can hold this back and submit it
> via your v4.8-fixes submission?

I've not applied this patch and had no intention of applying it, the
whole point in me acking it was that I was expecting it to get applied
as part of the series since AFAICT everything needed to go in together.
Your pattern of acking patches you're expecting to be apply yourself is
fairly unusual, if it's someone else it's generally safe to assume
they're expecting the patch to go via another tree.

If this still needs sorting after the merge window please resend it, or
ideally it can go in along with the rest of the series via whatever path
that's taking.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160701/72565843/attachment.sig>
