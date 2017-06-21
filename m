From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jun 2017 08:48:55 +0200
Subject: [PATCH] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <20170620114536.GA4766@Red>
References: <20170620085819.20114-1-clabbe.montjoie@gmail.com>
 <20170620095947.i3r3iym2cxz5jciw@flea.lan>
 <20170620114536.GA4766@Red>
Message-ID: <20170621064855.z5mu4f3r3dt4kotc@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 01:45:36PM +0200, Corentin Labbe wrote:
> On Tue, Jun 20, 2017 at 11:59:47AM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > On Tue, Jun 20, 2017 at 10:58:19AM +0200, Corentin Labbe wrote:
> > > The Security System have a PRNG, this patch add support for it via
> > > crypto_rng.
> > 
> > This might be a dumb question, but is the CRYPTO_RNG code really
> > supposed to be used with PRNG?
> > 
> 
> Yes, see recently added drivers/crypto/exynos-rng.c

It's still not really clear from the commit log (if you're talking
about c46ea13f55b6) why and if using the RNG code for a PRNG is a good
idea.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170621/af78c03e/attachment.sig>
