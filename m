From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 14:56:51 +0000
Subject: [GIT PULL] prima2 GPIO support in pinmux
In-Reply-To: <CAGsJ_4zjKprZn+gDASsKg9pspntagNMOvuQSj1VdK_YgzXn6hA@mail.gmail.com>
References: <CAGsJ_4xrk0w5aQy+ZSYZwQ3pW5My7dcHnDX57+985VTbdHXCzg@mail.gmail.com>
 <201207041429.47124.arnd@arndb.de>
 <CAGsJ_4zjKprZn+gDASsKg9pspntagNMOvuQSj1VdK_YgzXn6hA@mail.gmail.com>
Message-ID: <201207041456.52197.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Barry Song wrote:
> 2012/7/4 Arnd Bergmann <arnd@arndb.de>:
> > On Monday 02 July 2012, Barry Song wrote:
> >> Hi Olof, Arnd,
> >>
> >> Please pull the following GPIO support in pinmux for 3.6.
> >
> > I noticed that the driver now requires gpiolib, so we need one
> > of these two patches. I think the first one is safer, but the
> > second one allows you to build without GPIOLIB if you want to
> > disable PINCTRL_SIRF.
> 
> yes. missed this. thanks!
> i would have 1 because basically we will always have PINCTRL_SIRF.

Ok, I take that as an Ack. I've applied the patch on top of your
series now.

Thanks for confirming,

	Arnd
