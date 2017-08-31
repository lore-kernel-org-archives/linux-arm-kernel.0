From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Aug 2017 21:02:27 -0400 (EDT)
Subject: [PATCH v2 0/5] make XIP kernel .data compressed in ROM
In-Reply-To: <SG2PR06MB11652EB1FEDDE2F40AE763B18A9D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170830025547.30347-1-nicolas.pitre@linaro.org>
 <SG2PR06MB1165EF18A363D9CC4C5531FE8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1708301951330.2606@knanqh.ubzr>
 <SG2PR06MB11652EB1FEDDE2F40AE763B18A9D0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <nycvar.YSQ.7.76.1708302058520.2606@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Aug 2017, Chris Brandt wrote:

> On Wednesday, August 30, 2017, Nicolas Pitre wrote:
> > > > This work highlighted some defficiencies in linker scripts, especially
> > > > the XIP one. So this also includes linker script cleanups and fixes.
> > >
> > > Thank you for this!
> > 
> > More will come eventually.
> > 
> > Did this fix your cramfs issue with 4.13-rc7?
> 
> Yes!
> I just stacked on your latest set of cramfs XIP patches on top of these 
> and now magically it boots again.
> Thank you!

Excellent! If you could post this conclusion and your Tested-by in the 
cramfs thread for the benefit of that audience there that'd be helpful.


Nicolas
