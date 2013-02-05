From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Feb 2013 12:25:58 +0100
Subject: [GIT PULL] i.MX clock fixes for v3.8
In-Reply-To: <20130205110804.GI17786@n2100.arm.linux.org.uk>
References: <20130205095844.GZ1906@pengutronix.de>
 <20130205110804.GI17786@n2100.arm.linux.org.uk>
Message-ID: <20130205112558.GA1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 11:08:04AM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 05, 2013 at 10:58:44AM +0100, Sascha Hauer wrote:
> > Hi Arnd, Olof,
> > 
> > Please pull these two fixes for v3.8
> 
> If you haven't heard, Linus wants each and every patch going into v3.8
> meeting this criteria:
> 
>        fix major security issues, big user-reported regressions, or nasty
>        oopses.
> 
> and individually justified:
> 
>        So think twice - or thrice - before sending me patches or a pull
>        request for -rc7. You need to have some seriously good reasons for
>        doing so, and you need to state those reasons very clearly. And I
>        don't just mean for the pull request in general, I mean for every
>        single patch in it.
> ...
>        In other words, "It fixes a bug" just isn't good enough. The bug needs
>        to be something that actually matters.

At least 'ARM: i.MX25: clk: parent per5_clk to AHB clock' is a
regression that causes nasty oopses. Admittedly, it wasn't introduced in
the last merge window and the board requiring the fix needs out of tree
patches.

I'm fine with these going into v3.9 and waiting for the first stable
patch to get the fix for the above.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
