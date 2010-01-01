From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 1 Jan 2010 15:54:51 +0100
Subject: tree with htc dream support
In-Reply-To: <a55d774e0912281308u1c20c84cl4f264aa366445131@mail.gmail.com>
References: <20091227093537.GD11737@elf.ucw.cz>
	<20091227201514.GA29174@elf.ucw.cz>
	<a55d774e0912271220p1d102b1dr398e0524c9386702@mail.gmail.com>
	<20091227203704.GK11737@elf.ucw.cz>
	<20091227211322.GB29174@elf.ucw.cz>
	<a55d774e0912271646m1b82687cy427083e64e91e323@mail.gmail.com>
	<20091227101824.GB1478@ucw.cz>
	<a55d774e0912281224y7360dfdbu8a251743026bdd28@mail.gmail.com>
	<20091228204848.GB1637@ucw.cz>
	<a55d774e0912281308u1c20c84cl4f264aa366445131@mail.gmail.com>
Message-ID: <20100101145451.GD3944@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

(sorry for long response time, holidays with poor network connection).

> >> and get the core stuff in there so clock, power, etc support is there
> >> for the platform rather than have it live in staging purgatory.
> >>
> >> Since this stuff is integral to mach-msm, required for essential
> >> operation of the platform, and makes sense to be part of the mach-msm
> >> codebase, why not just fix it there rather than move it out into
> >> staging and then back? ?I'm not sure what that gains us.
> >
> > Well, it is in staging now. I just want you to use the existing
> > version, instead of adding another one.
> 
> I'm trying to understand where the version in staging came from, how
> it's been changed, etc, so I can resolve that against what we have
> that's known good and shipping today and make sure we're not losing
> bugfixes and such along the way.

> Do you remember where the smd code that you put into staging came
> from, exactly?  Unfortunately since things have been moved, modified,
> renamed, etc, getting clean diffs is a bit of an adventure right
> now.

I believe the version in staging is from 2.6.29-msm tree. Anyway,
changes should be pretty simple to see on diff -u (I belive I tried
that at one point).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
