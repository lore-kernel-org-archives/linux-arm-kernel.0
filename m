From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 24 Nov 2016 21:08:34 +0100
Subject: [PATCH] ARM: dts: sunxi: Enable UEXT related nodes for Olimex
 A20 SOM EVB
In-Reply-To: <20161123181610.cae67ad53f5f69246d341b30@bidouilliste.com>
References: <20161121164911.76900-1-manu@bidouilliste.com>
 <20161123080350.fstwdfndghk7c5xx@lukather>
 <20161123181610.cae67ad53f5f69246d341b30@bidouilliste.com>
Message-ID: <20161124210834.a7da24a53b09364e8ab391d6@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Nov 2016 18:16:10 +0100
Emmanuel Vadot <manu@bidouilliste.com> wrote:

> On Wed, 23 Nov 2016 09:03:50 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Mon, Nov 21, 2016 at 05:49:11PM +0100, Emmanuel Vadot wrote:
> > > UEXT are Universal EXTension connector from Olimex. They embed i2c, spi
> > > and uart pins along power in one connector and are found on most,
> > > if not all, Olimex boards.
> > > The Olimex A20 SOM EVB have two UEXT connector so enable the nodes found on
> > > those two connectors.
> > > 
> > > Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
> > 
> > Fixed the indentation of the spi pinctrl cells, and applied.
> > 
> > Please note that I'm note planning to send any new pull request, so
> > this will likely end up in 4.11.
> > 
> > Thanks!
> > Maxime
> > 
> > -- 
> > Maxime Ripard, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com
> 
>  Sorry about the indentation, I'll be more carefull next time.
> 
>  Thank you.
> 
> -- 
> Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
> 

 Hi Maxime,

 Re-reading the patch I've seen that I've not enabled the SPI nodes, I
guess it's easier if you revert my patch and that I send a new one ?

 Cheers,

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
