From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 3 Sep 2012 11:15:18 +0000
Subject: [PATCH 4/4] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <504434E8.9040205@snapgear.com>
References: <1346264842-20411-1-git-send-email-linus.walleij@linaro.org>
 <201209021849.54348.arnd@arndb.de> <504434E8.9040205@snapgear.com>
Message-ID: <201209031115.18539.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 September 2012, Greg Ungerer wrote:
> >
> > Note that this platform is one of those we talked about removing
> > from the kernel for potentially being completely unused. Do we have
> > reason to believe that people are still using ks8695 for anything
> > with new kernels?
> 
> I'll put my hand up as a user of it. I run every release kernel
> on KS8695 platforms, though I don't tend to do much testing of
> rc kernels on it.

Ok, very good. Booting every new kernel on a platform is more testing
than a lot of the older platforms get as far as I can tell.

> > If any of you are doing that, we'll definitely keep the port around,
> > the idea is not to break anything that people are actually using.
> > In that case, I would like to see a MAINTAINERS entry for the platform
> > so we have a contact for someone who is able to ack and maybe test
> > patches.
> 
> I am happy enough to ack and test changes, if no one else wants to
> do it. I don't expect to do any real active development on it though.
> I do have some board files that would have been nice to push into
> mainline, but I have been holding off (for quite a while), hoping
> that someone might support DTs on this sub-arch.

If nobody is actually working on new stuff, we might be better off
with just merging the board files you have. If you don't mind, just
post what you have and then we can decide what to do with them.

	Arnd
