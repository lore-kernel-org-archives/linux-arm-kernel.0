From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Jul 2013 23:58:21 +0200
Subject: [PATCH] ASoC: Allow imx-pcm-{dma,fiq}.c to be modules
In-Reply-To: <20130705211920.GK27646@sirena.org.uk>
References: <201307051745.16140.arnd@arndb.de>
 <201307052255.10765.arnd@arndb.de> <20130705211920.GK27646@sirena.org.uk>
Message-ID: <201307052358.22068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 July 2013, Mark Brown wrote:
> On Fri, Jul 05, 2013 at 10:55:10PM +0200, Arnd Bergmann wrote:
> > On Friday 05 July 2013, Mark Brown wrote:
> 
> > > Is this actually OK with the FIQ APIs?
> 
> > I don't know. Why wouldn't it?
> 
> It was the only reason I could think of why that'd have been done.

I looked in the log and found this part has been patched a couple
of times already, going back and forth between "bool" and "tristate",
always to fix build errors.

Please hold back for now, I'll try to reproduce on the bug on
the current torvalds tree first. I know it was broken in linux-next
as of a few weeks ago, but something else may have changed in the
meantime.

	Arnd
