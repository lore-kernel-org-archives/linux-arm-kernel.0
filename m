From: mgreer@animalcreek.com (Mark A. Greer)
Date: Wed, 17 Jul 2013 09:10:23 -0700
Subject: [PATCH 1/2] ARM: dts: Add SHAM data and documentation for AM33XX
In-Reply-To: <51E620AE.8090602@ti.com>
References: <1374017368-5267-1-git-send-email-mgreer@animalcreek.com>
 <1374017368-5267-2-git-send-email-mgreer@animalcreek.com>
 <51E620AE.8090602@ti.com>
Message-ID: <20130717161023.GA12124@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:12:22AM +0530, Lokesh Vutla wrote:
> Hi Mark,

Hi Lokesh.

> On Wednesday 17 July 2013 04:59 AM, Mark A. Greer wrote:
> > From: "Mark A. Greer" <mgreer@animalcreek.com>

> > diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> > index 0c8ad17..b04aea1 100644
> > --- a/arch/arm/boot/dts/am335x-evmsk.dts
> > +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> > @@ -401,4 +401,7 @@
> >  &cpsw_emac1 {
> >  	phy_id = <&davinci_mdio>, <1>;
> >  	phy-mode = "rgmii-txid";
> > +
> > +&sham {
> > +	status = "okay";
>  "};" is missing here.
> >  };

Ugh, yeah, I somehow mess that out.

Thanks for pointing that out.

Mark
--
