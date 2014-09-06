From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 06 Sep 2014 16:09:29 +0200
Subject: arm: Add basic support for MediaTek MT8127 & MT8135 SoCs
In-Reply-To: <CABuKBeLNyHbNjzcZ0jmjPmxEbSBPuzur-Dmuzed0kOJ5W9C4bg@mail.gmail.com>
References: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <15158935.ieDDcCvpAL@wuerfel>
 <CABuKBeLNyHbNjzcZ0jmjPmxEbSBPuzur-Dmuzed0kOJ5W9C4bg@mail.gmail.com>
Message-ID: <2858628.XILj3pUtxM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 September 2014 09:27:28 Matthias Brugger wrote:
> 2014-09-05 21:36 GMT+02:00 Arnd Bergmann <arnd@arndb.de>:
> > Hello Joe,
> >
> > On Friday 05 September 2014 07:50:55 Joe. C wrote:
> >> This series add basic device tree support MT8127 & MT8135.
> >> This series is based on v3.17-rc3.
> >>
> >> We are planning to upstream drivers for MT8127 & MT8135 SoCs.
> >> MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
> >> tablet soc with 4 CA7. They share many similar IP components
> >> with MT65xx series.
> >
> > The patches look very nice to me, I'm glad to hear you have
> > plans to upstream more.
> >
> >> Please note this one is not base on intpol [1] patches I sent
> >> last month. Base on the discussion on intpol, I think it might
> >> take some more time. I'd like to have this merge first so we
> >> can work on other stuff simultaneously.
> >
> > Yes, I agree. I'll wait for Matthias to pick up your patches
> > and send a pull request for them.
> 
> The patches look fine to me, apart from the inconsistency in the
> subject. I will fix this when I pick them.
> I'm just wondering if I should wait until we get an ACK from the DTS maintainer.

It surely doesn't hurt to wait a bit more, but if it takes too
long, you can just apply the patches. For all I can tell, only
documented bindings are used, and it's more important to
review new or extended bindings.

	Arnd
