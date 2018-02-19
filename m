From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Mon, 19 Feb 2018 11:43:10 +0100
Subject: [PATCH v3 5/7] arm: dts: sun8i: a83t: Add CCI-400 node
In-Reply-To: <20180219084944.iqrdzhpl63gdf6wy@flea.lan>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
 <20180219081837.15482-6-mylene.josserand@bootlin.com>
 <20180219084944.iqrdzhpl63gdf6wy@flea.lan>
Message-ID: <20180219114310.6b60b775@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 19 Feb 2018 09:49:44 +0100
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> Hi,
> 
> On Mon, Feb 19, 2018 at 09:18:35AM +0100, Myl?ne Josserand wrote:
> > +				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
> > +				<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;  
> 
> You should align these blocks on the first one in the array.

Yep, thanks.

Myl?ne

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
