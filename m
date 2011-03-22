From: gxt@mprc.pku.edu.cn (Guan Xuetao)
Date: Tue, 22 Mar 2011 21:43:46 +0800
Subject: [PATCH] ARM: Use asm-generic/sizes.h
In-Reply-To: <201103221110.20861.arnd@arndb.de>
References: <1300751462-1494-1-git-send-email-sboyd@codeaurora.org>
	<201103220934.50435.arnd@arndb.de>
	<20110322092113.GB17264@n2100.arm.linux.org.uk>
	<201103221110.20861.arnd@arndb.de>
Message-ID: <00ec01cbe897$2eed7210$8cc85630$@mprc.pku.edu.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Firstly, the sizes.h is do derived from arm version.
And I just complete the SZ_* definitions for 32-bit architecture,
and remove SZ_48M for not being power-of-2 size.
I am sorry for removing copyright information when cleaning-up the code.
However, the content of this file is so common sense for handy sizes.
So, I believe that GPLv2 license is enough.

Regards.

Guan Xuetao

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, March 22, 2011 6:10 PM
> To: linux-arm-kernel at lists.infradead.org; Guan Xuetao
> Cc: Russell King - ARM Linux; Stephen Boyd; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] ARM: Use asm-generic/sizes.h
> 
> On Tuesday 22 March 2011, Russell King - ARM Linux wrote:
> > On Tue, Mar 22, 2011 at 09:34:50AM +0100, Arnd Bergmann wrote:
> > > On Tuesday 22 March 2011, Stephen Boyd wrote:
> > > > Commit d232b12 (asm-generic headers: add sizes.h, 2011-01-15)
> > > > introduced a generic sizes.h. Use that instead of the ARM specific
> > > > version.
> > > >
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > >
> > > Acked-by: Arnd Bergmann <arnd@arndb.de
> >
> > I assume the generic version was derived from the ARM version.  Is there
> > a reason why ARM Ltd's copyright was seemingly dropped?
> 
> I'll let Guan Xuetao answer that, he introduced the file along with the
> unicore32 architecture.
> 
> I doubt that the contents of this file are copyrightable, but of course
> that is normally no reason to remove the notice.
> 
> 	Arnd
