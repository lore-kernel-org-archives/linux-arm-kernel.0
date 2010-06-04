From: pieterg@gmx.com (pieterg)
Date: Fri, 4 Jun 2010 11:37:18 +0200
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100604085629.GU2695@buzzloop.caiaq.de>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006041036.39059.pieterg@gmx.com>
	<20100604085629.GU2695@buzzloop.caiaq.de>
Message-ID: <201006041137.18270.pieterg@gmx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 June 2010 10:56:29 Daniel Mack wrote:
> On Fri, Jun 04, 2010 at 10:36:39AM +0200, pieterg wrote:
> > On Friday 04 June 2010 03:10:14 Marek Vasut wrote:
> > > I just tested, PXA (mach-pxa) probably can be compiled into single
> > > kernel supporting all the boards.
> >
> > For my boards (colibri) I see only one exception; I haven't managed to
> > build a single kernel with support for different AC97 chips.
>
> Which problems did you have when tring this?

Hm, thanks for making me try this again. I was convinced a UCB1400 
touchscreen was not recognised when I had CONFIG_TOUCHSCREEN_WM97XX in the 
config, but trying this again now shows it works fine.
I must have drawn the wrong conclusion back then.
Glad I can use a single config for my boards now.

Rgds, Pieter
