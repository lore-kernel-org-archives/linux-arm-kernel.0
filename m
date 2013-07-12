From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jul 2013 12:18:38 +0100
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <2463181.bQfIDO6XJk@thinkpad>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <2214161.FSfscAvpna@thinkpad>
 <20130711130139.GQ24508@sirena.org.uk>
 <2463181.bQfIDO6XJk@thinkpad>
Message-ID: <20130712111838.GZ24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 12:13:17PM +0200, Tomasz Figa wrote:
> On Thursday 11 of July 2013 14:01:39 Mark Brown wrote:

> > Well, it *should* be samsung,i2s-vN where N is the version number of the
> > IP but documentation on the versioning has been patchy hence this whole
> > thinng.

> Oh, the binding for samsung-i2s uses IP versions. Isn't that slightly broken?

> At least with Samsung bindings, I think we happened to agree on a single 
> convention of naming compatible values after the first SoC in which such block 
> first appeared.

> I wonder what happened with this i2s binding that made it end up outside this 
> convention.

I think it predates that convention, plus it's been quite common to put
two different I2S blocks in the same SoC (for totally sensible reasons)
so it's not always been clear that the SoC name is sufficiently unique.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/1898d978/attachment.sig>
