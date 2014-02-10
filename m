From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Feb 2014 13:09:46 +0100
Subject: [RFC PATCHv2 0/4] Add DT support for fixed PHYs
In-Reply-To: <CAH9NwWfutp6MitSuG-LNH=0Y0ffewuSawLXJOe2JUL7=tz7BWQ@mail.gmail.com>
References: <1378480701-12908-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130911064248.GI30088@pengutronix.de>
 <CAH9NwWfBGHmZ+HfUndeh18NW+HyZ=c82W=O_4hJSOH-oZuM9jA@mail.gmail.com>
 <CAH9NwWfutp6MitSuG-LNH=0Y0ffewuSawLXJOe2JUL7=tz7BWQ@mail.gmail.com>
Message-ID: <20140210130946.6a554659@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Christian Gmeiner,

On Mon, 10 Feb 2014 11:30:30 +0100, Christian Gmeiner wrote:

> >> +1 for the general idea. This really looks good now. I've not much more
> >> to say. Maybe someone from the devicetree corner has a few words for the
> >> binding?
> >>
> >
> > I tested the whole series with an I.MX6D board with the FEC driver:
> > fec 2188000.ethernet eth0: Freescale FEC PHY driver [Generic PHY]
> > (mii_bus:phy_addr=fixed-0:00, irq=-1)
> >
> > For me binding looks nice and I hope to see this patch series in 3.13.
> >
> > Tested-by: Christian Gmeiner <christian.gmeiner@gmail.com>
> 
> Is there any update on this patch series?

I'll try to send a new version in the next few days. It's still part of
my TODO list.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
