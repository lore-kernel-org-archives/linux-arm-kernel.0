From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 9 Dec 2009 12:32:48 +0100
Subject: GPIO support for HTC Dream
In-Reply-To: <d6200be20912081356i57793417u7bfb2b851fc22521@mail.gmail.com>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208213727.GA4164@elf.ucw.cz>
	<d6200be20912081356i57793417u7bfb2b851fc22521@mail.gmail.com>
Message-ID: <20091209113248.GB22752@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2009-12-08 13:56:00, Arve Hj?nnev?g wrote:
> On Tue, Dec 8, 2009 at 1:37 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> > +#undef MODULE_PARAM_PREFIX
> >> > +#define MODULE_PARAM_PREFIX "board_dream."
> >>
> >> This looks a bit dodgy. Is this
> >> (http://lkml.indiana.edu/hypermail/linux/kernel/0903.0/02768.html) the
> >> preferred way?
> >
> > I don't think that would help that much here....
> 
> That should work, but you have to use board_trout, not board_dream.
> Many of these parameters passed on the kernel command-line by the
> bootloader which uses board_trout. Others are used by userspace which
> also expects to find them under board_trout.

Ok, lets go for board_trout (and a comment). I guess compatibility is
somehow important here.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
