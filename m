From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Mar 2011 09:21:13 +0000
Subject: [PATCH] ARM: Use asm-generic/sizes.h
In-Reply-To: <201103220934.50435.arnd@arndb.de>
References: <1300751462-1494-1-git-send-email-sboyd@codeaurora.org>
	<201103220934.50435.arnd@arndb.de>
Message-ID: <20110322092113.GB17264@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 09:34:50AM +0100, Arnd Bergmann wrote:
> On Tuesday 22 March 2011, Stephen Boyd wrote:
> > Commit d232b12 (asm-generic headers: add sizes.h, 2011-01-15)
> > introduced a generic sizes.h. Use that instead of the ARM specific
> > version.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de

I assume the generic version was derived from the ARM version.  Is there
a reason why ARM Ltd's copyright was seemingly dropped?
