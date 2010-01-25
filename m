From: dsilvers@simtec.co.uk (Daniel Silverstone)
Date: Mon, 25 Jan 2010 10:49:59 +0000
Subject: Default machine include placements
In-Reply-To: <20100125104425.GO26562@trinity.fluff.org>
References: <20100125040255.GN26562@trinity.fluff.org>
	<20100125100546.GA16340@n2100.arm.linux.org.uk>
	<20100125103216.GB5772@digital-scurf.org>
	<20100125104425.GO26562@trinity.fluff.org>
Message-ID: <20100125104959.GC5772@digital-scurf.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 10:44:25AM +0000, Ben Dooks wrote:
> We do a bit of #include <plat/xxx-base.h> already for some things.
> The 'empty' headers always seme to end up catching more copyright
> statement than the space they end up saving.

I guess it depends if you're aiming for space savings or "only one place to fix
a bug" in that case.

> Not sure how git deals with symlinks, and I think this will just leave
> us a mess on systems that don't really understand symlinks.

Does the kernel even build on systems which don't properly support symbolic
links?  I thought we had more problems with caseless filesystems anyway?

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
