From: matthias@kaehlcke.net (Matthias Kaehlcke)
Date: Thu, 25 Mar 2010 18:28:12 +0100
Subject: [BUG] i.MX25: Broken include in mach-mx25pdk.c
In-Reply-To: <20100325164147.GA27698@jasper.tkos.co.il>
References: <20100325161635.GI2328@darwin>
	<20100325164147.GA27698@jasper.tkos.co.il>
Message-ID: <20100325172811.GJ2328@darwin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

El Thu, Mar 25, 2010 at 06:41:47PM +0200 Baruch Siach ha dit:

> On Thu, Mar 25, 2010 at 05:16:35PM +0100, Matthias Kaehlcke wrote:
> > compiling arch/arm/mach-mx25/mach-mx25pdk.c fails due to the missing
> > include "linux/fec.h" and incomplete types that are supposed to
> > defined in this header
> > 
> > i'd send a fix, but greping through the kernel tree i haven't been
> > able to identify the file defining the missing elements, i suppose it's still
> > sitting bored in some development tree waiting to be merged
> 
> Apply the patch at http://patchwork.ozlabs.org/patch/41235/.
> 
> For some reason this patch never made it to the mainline even after my 
> repeated nagging :(.

thanks for the pointer, baruch!

david: is there any inconvenience to merge the patch to netdev? if so,
what can be done to make it mergeable?

regards

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

      The assumption that what currently exists must necessarily
        exist is the acid that corrodes all visionary thinking
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
