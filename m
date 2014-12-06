From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 6 Dec 2014 19:04:29 +0100
Subject: N900: fixing MMC at boot
In-Reply-To: <201412061840.16157@pali>
References: <20141206173526.GA7964@amd>
 <201412061840.16157@pali>
Message-ID: <20141206180429.GA312@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2014-12-06 18:40:16, Pali Roh?r wrote:
> On Saturday 06 December 2014 18:35:27 Pavel Machek wrote:
> > Hi!
> > 
> > For a long time, MMC was not working during boot... (making
> > the box unusable without nfsroot). It seems problem is in the
> > regulators, because with diff below, I was able to mount root
> > on SD card for a first time ... in a long time.
> > 
> 
> Hi, do you mean external SD card or internal eMMC (MyDocs)?

I mean u-SD card. But it is strange. I reverted the patch now, and it
still works. Not sure why or what I've done differently.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
