From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 26 Sep 2018 11:52:02 +0200
Subject: [PATCH] arm64: dts: allwinner: a64: Re-add "syscon" compatible
In-Reply-To: <20180924112230.73e3009b@donnerap.Emea.Arm.com>
References: <20180917152857.162662-1-andre.przywara@arm.com>
 <CAGb2v643=V_3DbLeEyXEavSQJsW2KdknpZZLfw4QwCjhfdmVsA@mail.gmail.com>
 <20180921153522.0413c280@donnerap.Emea.Arm.com>
 <20180921151625.wkaypyueyi2pguur@flea>
 <20180924112230.73e3009b@donnerap.Emea.Arm.com>
Message-ID: <20180926095202.tdibor3x7fsn6afz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 11:22:30AM +0100, Andre Przywara wrote:
> > The fundamental difference is that we're mostly just a bunch of spare
> > time programmers working on this platform, with a partial
> > documentation for the controllers, at best.
> > 
> > You forced me to ask these developpers to work on their weekends and
> > evenings on some crazy corner cases to maintain the backward
> > compatibility. And honestly, both from a technical and human
> > standpoint, I definitely understand if some of them are just leaving
> > and don't want to work on it anymore. I would probably do the same in
> > their position.
> > 
> > And having to ask that for companies like ARM or SUSE just makes it
> > more frustrating to be honest. So there's simply no way you have
> > forward compatibility while I'm there. Or you manage to convince all
> > the ARM maintainers and enforce that compatibility for all the
> > platforms.
> 
> I understand that from your point of view there is no way of investing
> huge efforts in staying forward compatible, but I am not asking for
> that (and by no way forcing this!). Instead this suggestion is a small
> tweak to achieve this.

We're trying to remain compatible but if there's any technical reason,
then we won't be. I don't want anyone to assume we will, and to rely
on the fact that we are actually guaranteeing this.

> So I am sorry if those things frustrate you (which I can understand
> very well), but I believe fixing the DT in a proper way is
> much more user friendly in the long term (actually this issue was
> brought forward by a user[1]).

Given the current state of the industry, I don't really see how the DT
can allow you to do what you are trying to achieve.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
