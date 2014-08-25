From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 25 Aug 2014 10:44:35 +0800
Subject: [PATCH] ARM: dts: imx28-evk: Fix display duplicate name warning
In-Reply-To: <CAOMZO5DySdUd8j583jEGCgX0oG8i8i1488M6MER-7Ys23fQ0Nw@mail.gmail.com>
References: <1408672772-6365-1-git-send-email-festevam@gmail.com>
 <20140825022751.GI2540@dragon>
 <CAOMZO5DySdUd8j583jEGCgX0oG8i8i1488M6MER-7Ys23fQ0Nw@mail.gmail.com>
Message-ID: <20140825024434.GJ2540@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 24, 2014 at 11:34:31PM -0300, Fabio Estevam wrote:
> On Sun, Aug 24, 2014 at 11:27 PM, Shawn Guo <shawn.guo@freescale.com> wrote:
> 
> > Unit address only makes sense where parent has #address-cells and
> > #size-cells and the node itself has 'reg' property.
> 
> Ok, I followed the way arch/arm/boot/dts/imx28-tx28.dts implemented
> the display node.
> 
> > I guess it's more appropriate to name the node in particular display
> > device model that the node is defining?
> 
> Sorry, I did not understand. Could you please provide an example for
> clarification?

See LVDS panel example in arch/arm/boot/dts/imx6qdl-sabresd.dtsi

Shawn
