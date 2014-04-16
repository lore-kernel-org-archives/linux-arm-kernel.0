From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 16 Apr 2014 21:50:21 +0800
Subject: [PATCH] hwrng: remove unbuildable picoxcell TRNG
In-Reply-To: <20140415100614.GA2037@page.Home>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-7-git-send-email-richard@nod.at>
 <1391977683.25855.27.camel@x220> <1397552118.1985.16.camel@x220>
 <20140415100614.GA2037@page.Home>
Message-ID: <20140416135021.GI4684@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 11:06:14AM +0100, Jamie Iles wrote:
> Hi Paul,
> 
> On Tue, Apr 15, 2014 at 10:55:18AM +0200, Paul Bolle wrote:
> > The driver for the "Picochip picoXcell true random number generator" was
> > added in v2.6.39. Its Kconfig symbol has always depended on
> > PICOXCELL_PC3X3. But that Kconfig symbol has never been part of the
> > tree. This means this driver has never been buildable. Let's remove it.
> > It can be re-added if its dependencies are actually part of the tree.
> > 
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> 
> I wish I had the bandwidth to get this properly supported, but this 
> seems sensible to me.
> 
> Acked-by: Jamie Iles <jamie@jamieiles.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
