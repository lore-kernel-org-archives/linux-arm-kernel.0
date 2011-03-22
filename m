From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Mar 2011 11:10:20 +0100
Subject: [PATCH] ARM: Use asm-generic/sizes.h
In-Reply-To: <20110322092113.GB17264@n2100.arm.linux.org.uk>
References: <1300751462-1494-1-git-send-email-sboyd@codeaurora.org>
	<201103220934.50435.arnd@arndb.de>
	<20110322092113.GB17264@n2100.arm.linux.org.uk>
Message-ID: <201103221110.20861.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 22 March 2011, Russell King - ARM Linux wrote:
> On Tue, Mar 22, 2011 at 09:34:50AM +0100, Arnd Bergmann wrote:
> > On Tuesday 22 March 2011, Stephen Boyd wrote:
> > > Commit d232b12 (asm-generic headers: add sizes.h, 2011-01-15)
> > > introduced a generic sizes.h. Use that instead of the ARM specific
> > > version.
> > > 
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de
> 
> I assume the generic version was derived from the ARM version.  Is there
> a reason why ARM Ltd's copyright was seemingly dropped?

I'll let Guan Xuetao answer that, he introduced the file along with the
unicore32 architecture.

I doubt that the contents of this file are copyrightable, but of course
that is normally no reason to remove the notice.

	Arnd
