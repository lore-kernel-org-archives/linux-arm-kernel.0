From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Oct 2015 14:52:42 +0200
Subject: next-20151013 build: 1 failures 50 warnings (next-20151013)
In-Reply-To: <20151013125026.GG14956@sirena.org.uk>
References: <E1ZlxDc-0000ea-U4@optimist> <20151013125026.GG14956@sirena.org.uk>
Message-ID: <10774670.W40zvvZu4L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 October 2015 13:50:26 Mark Brown wrote:
> On Tue, Oct 13, 2015 at 11:54:09AM +0100, Build bot for Mark Brown wrote:
> 
> Today's linux-next fails to build an ARM allmodconfig due to:
> 
> >       arm-allmodconfig
> > ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:30: error: macro "DIV_ROUND_UP" requires 2 arguments, but only 1 given
> > ../drivers/firmware/broadcom/bcm47xx_nvram.c:110:4: error: 'DIV_ROUND_UP' undeclared (first use in this function)
> 
> triggered by f6e734a8c16229 (MIPS: BCM47xx: Move NVRAM driver to the
> drivers/firmware/).  Presumably this works due to an implicit inclusion
> on MIPS.
> 
> I've CCed a lot of people listed in the changelog of the patch, though
> the list there appears somewhat random - apologies if this is irrelevant
> to you.

I've submitted a patch yesterday, see https://lkml.org/lkml/2015/10/12/303

	ARnd
