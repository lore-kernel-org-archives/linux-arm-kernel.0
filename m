From: pavel@denx.de (Pavel Machek)
Date: Sat, 27 Oct 2012 13:56:16 +0200
Subject: [PATCH] Fix socfpga compilation with early_printk() enabled
In-Reply-To: <201210251458.48528.arnd@arndb.de>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <20120701184110.GA30680@elf.ucw.cz>
 <20121017181648.GA12120@elf.ucw.cz>
 <201210251458.48528.arnd@arndb.de>
Message-ID: <20121027115615.GC5912@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > This fixes early_printk() compilation for
> > socfpga. (senduart/busyuart/waituart were missing). It does that by
> > making Picochip code generic.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > Acked-by: Dinh Nguyen <dinguyen@altera.com>
> > Acked-by: Jamie Iles <jamie@jamieiles.com 
> 
> Applied to fixes branch of arm-soc, but please be more explicit about
> what you want to happen with patches in the future. Ideally we would
> get pull requests for patches on each platform from only one person,
> so please coordinate with Dinh Nguyen who that should be.

Dinh is the maintainer, so if we can only send patches from one
person, it needs to be him. If you'd be willing to take patches from
second person, that would help us... if not, of course I can send all
the patches through Dinh.

> Some minor things:
> 
> * If you include something in the email that should not be part of
> the git changelog (e.g. "Hi!"), then please put it below the "---"
> line under the Signed-off list.

Ok.

> * you are missing a '>' after Jamies email address

Sorry.

> * When you submit a patch for inclusion, please always take both
> Olof and me on Cc on the email, since we are doing this work together
> and take turns, so you might not always know which one will take
> the patch. We have an alias "arm at kernel.org" that you can also
> use.

Olof Johansson <olof@lixom.net>? Can do.

But... perhaps you should add an entry into MAINTAINERS file
explaining all this? arm at kernel.org is not mentioned there, Olof is
not mentioned as maintaining arm. (And yes, I did check it before
original patch submission).

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
