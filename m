From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 28 Sep 2014 15:03:00 -0700
Subject: [PATCH 0/5] m25p80,spi-nor: Fix module aliases for m25p80; clean
 up chip identification
In-Reply-To: <1410714795.3040.45.camel@decadent.org.uk>
References: <1410714624.3040.38.camel@decadent.org.uk>
 <1410714795.3040.45.camel@decadent.org.uk>
Message-ID: <20140928220300.GB3248@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 14, 2014 at 06:13:15PM +0100, Ben Hutchings wrote:
> On Sun, 2014-09-14 at 18:10 +0100, Ben Hutchings wrote:
> > The first patch in the series restores the module aliases to m25p80, but
> > it does so by duplicating the list of names.  This should be suitable
> > for stable, but it isn't viable in the longer term.
> > 
> > The following patches change the spi-nor interface so that this
> > duplication is no longer necessary.  This includes removing
> > spi_nor::read_id, but it could be re-added after this with a different
> > interface, e.g. returning a flash_info structure (which would need to be
> > defined in spi_nor.h).
> 
> Note that these patch are:
> - Based on your 'testing' branch

Which testing branch? These two are the only official
repos for MTD:

    git git://git.infradead.org/linux-mtd.git
    git git://git.infradead.org/l2-mtd.git

> - Untested by me, aside from compiling and checking that m25p80 has the
>   expected module aliases

Brian
