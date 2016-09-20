From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Sep 2016 11:39:30 -0700
Subject: [PATCH] ARM: dts: Add power button support for igepv5
In-Reply-To: <20160920121521.GA32519@localhost.localdomain>
References: <20160909210729.20184-1-tony@atomide.com>
 <31409234-3185-5348-2d37-effb7769c92a@osg.samsung.com>
 <CAMVEqEkKrw2eH3L6+te5MZLqxBT2jUiRO-KNuS+9nuNYvihCRA@mail.gmail.com>
 <20160919230826.aubqvj2km4wg6gz7@atomide.com>
 <20160920121521.GA32519@localhost.localdomain>
Message-ID: <20160920183930.bwjnpg47ovd2lrfy@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ladislav Michl <ladis@linux-mips.org> [160920 05:15]:
> On Mon, Sep 19, 2016 at 04:08:26PM -0700, Tony Lindgren wrote:
> > * Pau Pajuel <ppajuel@gmail.com> [160919 01:13]:
> > > Hello Tony,
> > > 
> > > 2016-09-14 3:26 GMT+02:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> > > > Hello Tony,
> > > >
> > > > On 09/09/2016 05:07 PM, Tony Lindgren wrote:
> > > >> Add power button support for igepv5.
> > > >>
> > > >> Cc: Agust? Fontquerni i Gorchs <afontquerni@iseebcn.com>
> > > >> Cc: Enric Balletbo Serra <eballetbo@gmail.com>
> > > >> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> > > >> Cc: Pau Pajuel <ppajuel@gmail.com>
> > > >> Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > >> ---
> > > >
> > > > I don't have a schematics for this board, but the patch looks good to me.
> > > Patch has an errata. Power button is GPIO_ACTIVE_LOW instead GPIO_ACTIVE_HIGH.
> > 
> > Oops sorry about that, here's an incremental fix.
> 
> And here's another nitpick ;-)

Heh OK thanks, applying both into omap-for-v4.9/dt-v2.

Regards,

Tony
