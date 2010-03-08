From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Mar 2010 08:28:59 +0100
Subject: bit errors on spitz
In-Reply-To: <f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
References: <20100305212708.GC21773@elf.ucw.cz>
	<f17812d71003072137u51be17a1ie3e50e30dea16f77@mail.gmail.com>
Message-ID: <20100308072858.GA29939@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Mar 6, 2010 at 5:27 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> > I'm getting way too many bit errors on spitz, with various
> > kernels.
> >
> > It may be tied to network usage (bluetooth or wifi?). It happens even
> > on AC power.
> 
> Pavel,
> 
> What kind of bit errors? I'm not using any network here on my spitz so
> not sure what exactly was happening. Could you paste the dmesg here
> so we can help take a look?

dmesg would not be useful, it usually hits user programs. Like... mutt
suddenly displaying , instead of - in the header. Program failing to
start because function printg is not found (it was not exactly
printf->printg,  I don't remember exact symbol), ping complaining
about discarding corrupted packets, etc.

(Or of course, kernel oopsing or not going from suspend at all. But as
even user data are being corrupted, oops is not likely to be
interesting and system is typically not in state to capture it any more.)

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
