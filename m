From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Jan 2015 15:51:37 -0800
Subject: [PATCH 2/2] ARM: dts: DRA7X: drop id property in pcie_phy
In-Reply-To: <54993FC0.3090705@ti.com>
References: <1418721771-31184-1-git-send-email-vigneshr@ti.com>
 <1418721771-31184-3-git-send-email-vigneshr@ti.com>
 <54993FC0.3090705@ti.com>
Message-ID: <20150107235136.GK13010@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [141223 02:14]:
> 
> 
> On Tuesday 16 December 2014 02:52 PM, Vignesh R wrote:
> > Since phyid is no longer used by pcie driver, this field can be dropped
> > from the DT.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Applying into omap-for-v3.20/dt thanks.

Tony

> > ---
> >  arch/arm/boot/dts/dra7.dtsi | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> > index 63bf99be1762..889e3023e68f 100644
> > --- a/arch/arm/boot/dts/dra7.dtsi
> > +++ b/arch/arm/boot/dts/dra7.dtsi
> > @@ -1111,7 +1111,6 @@
> >  					      "wkupclk", "refclk",
> >  					      "div-clk", "phy-div";
> >  				#phy-cells = <0>;
> > -				id = <1>;
> >  				ti,hwmods = "pcie1-phy";
> >  			};
> >  
> > @@ -1132,7 +1131,6 @@
> >  					      "div-clk", "phy-div";
> >  				#phy-cells = <0>;
> >  				ti,hwmods = "pcie2-phy";
> > -				id = <2>;
> >  				status = "disabled";
> >  			};
> >  		};
> > 
