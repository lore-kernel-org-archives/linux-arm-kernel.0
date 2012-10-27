From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 27 Oct 2012 15:39:19 +0000
Subject: [PATCH] Fix socfpga compilation with early_printk() enabled
In-Reply-To: <20121027115615.GC5912@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201210251458.48528.arnd@arndb.de> <20121027115615.GC5912@elf.ucw.cz>
Message-ID: <201210271539.20156.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 October 2012, Pavel Machek wrote:

> > > This fixes early_printk() compilation for
> > > socfpga. (senduart/busyuart/waituart were missing). It does that by
> > > making Picochip code generic.
> > > 
> > > Signed-off-by: Pavel Machek <pavel@denx.de>
> > > Acked-by: Dinh Nguyen <dinguyen@altera.com>
> > > Acked-by: Jamie Iles <jamie@jamieiles.com 
> > 
> > Applied to fixes branch of arm-soc, but please be more explicit about
> > what you want to happen with patches in the future. Ideally we would
> > get pull requests for patches on each platform from only one person,
> > so please coordinate with Dinh Nguyen who that should be.
> 
> Dinh is the maintainer, so if we can only send patches from one
> person, it needs to be him. If you'd be willing to take patches from
> second person, that would help us... if not, of course I can send all
> the patches through Dinh.

You can both send patches, we just need to know what to expect. For most
platforms it works best if one person collects the patches from everyone.

If you are sending patches with both Dinh and us as the recipients,
just make it clear who you want to pick up the patch.

> > * When you submit a patch for inclusion, please always take both
> > Olof and me on Cc on the email, since we are doing this work together
> > and take turns, so you might not always know which one will take
> > the patch. We have an alias "arm at kernel.org" that you can also
> > use.
> 
> Olof Johansson <olof@lixom.net>? Can do.
> 
> But... perhaps you should add an entry into MAINTAINERS file
> explaining all this? arm at kernel.org is not mentioned there, Olof is
> not mentioned as maintaining arm. (And yes, I did check it before
> original patch submission).

We intentionally didn't put our names into the maintainers file because
that would mean getting Cc'd on every patch that should actually go
to one of the sub-maintainers instead.

We are adding an entry pointing to the arm-soc tree now though, just
without the arm at kernel.org entry.

	Arnd
