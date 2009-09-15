From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Sep 2009 12:37:39 +0200
Subject: [PATCH] arm: remove unused code in delay.S
In-Reply-To: <94a0d4530909140814w36f7f5f0td2c25db07fbd4e57@mail.gmail.com>
References: <1252875960-21512-1-git-send-email-felipe.contreras@gmail.com>
	<200909132328.47079.marek.vasut@gmail.com>
	<20090913230008.GC30169@n2100.arm.linux.org.uk>
	<20090914002100.GD30621@shareable.org>
	<20090914081001.GB14519@n2100.arm.linux.org.uk>
	<94a0d4530909140558nd8d2c47lc9954563c80a574f@mail.gmail.com>
	<20090914140059.GC21580@n2100.arm.linux.org.uk>
	<94a0d4530909140738t7e4d646r134cfd884da21348@mail.gmail.com>
	<20090914144028.GG21580@n2100.arm.linux.org.uk>
	<94a0d4530909140814w36f7f5f0td2c25db07fbd4e57@mail.gmail.com>
Message-ID: <20090915103739.GA19519@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> > Because then you get it whenever you configure for V4 as the lowest
> >> > denominator CPU, which leads to the buggy behaviour on better CPUs.
> >> > It's far better to leave it as is and just accept that the old CPUs
> >> > will have longer than necessary delays. ?If people really really
> >> > care (and there's likely to only be a small minority of them now)
> >> > changing the '0' to a '1' is a very simple change for them to carry
> >> > in their local tree. ?Unlike getting the right unrolling etc.
> >>
> >> Well, they can also 'git revert' this patch. If somebody really cares
> >> I think they should shout now and provide a better patch, otherwise
> >> this one should be merged.
> >
> > On the other hand, having the code there as it currently stands is not
> > harmful in any way, so leaving it there is just as easy.
> 
> It makes the code less understandable. I'm not sure about linux's
> practices, but an #if 0 generally means somebody is being lazy.

Not in this case, as you was explained to you. You may want to add
explaining comment above #if 0....
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
