From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 7 Dec 2009 11:07:03 +0100
Subject: HTC Dream: dream is better name for this machine
In-Reply-To: <a55d774e0912061527t5b09b510g1fc458b53a423c04@mail.gmail.com>
References: <20091206205041.GA12555@elf.ucw.cz>
	<a55d774e0912061527t5b09b510g1fc458b53a423c04@mail.gmail.com>
Message-ID: <20091207100703.GF23088@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2009-12-06 15:27:38, Brian Swetland wrote:
> On Sun, Dec 6, 2009 at 12:50 PM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > While few people may know HTC Dream by its codename, it is better to
> > use name of released hardware in the sources.
> 
> I still think that it'd be less pain for everyone to leave it as
> trout.  If you go by sales volume, the most known released hardware
> name is "Tmobile G1", some people know it as ADP1, and I believe it
> has sold under a few other names in other markets, but the software

Yes, operators brand their handsets. Unfortunately g1/adp1 names suck
-- for being alphabet soups -- and HTC Dream *is* name of the
hardware.

http://en.wikipedia.org/wiki/HTC_Dream

(and it is certainly better name than trout).

> has, since day one, been trout and changing that just makes it harder
> to merge other existing changes where we'd have to deal with renames
> as well.  The bootloader identifies it as "trout", and the userspace
> software stack's hardware-specific bits refer to trout.

Well, the longer we wait, the harder it will be to change the nema...

> If it really drives everyone crazy, we could do a big rename once it's
> all in and working, but right now I just don't see the benefit.

It is normally better to change such stuff before merging to
mainline. Splitting/cleaning patches is generally enough work that
little renaming should not be huge problem. 
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
