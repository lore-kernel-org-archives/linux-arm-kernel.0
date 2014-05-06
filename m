From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 May 2014 11:35:38 +0900
Subject: [PATCH] arm: dts: exynos4: add missing pinctrls for I2C
 controllers
In-Reply-To: <534E7F1A.8080502@samsung.com>
References: <534E7A3F.7050406@samsung.com> <534E7F1A.8080502@samsung.com>
Message-ID: <099a01cf68d3$de1044b0$9a30ce10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Tomasz,
> 
> On 16.04.2014 14:40, Tomasz Stanislawski wrote:
> > This patch adds missing pinctrls for I2C controllers 2-7.
> >
> > Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
> > ---
> >   arch/arm/boot/dts/exynos4.dtsi |   12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/exynos4.dtsi
> b/arch/arm/boot/dts/exynos4.dtsi
> > index 0401f4d..288aa81 100644
> > --- a/arch/arm/boot/dts/exynos4.dtsi
> > +++ b/arch/arm/boot/dts/exynos4.dtsi
> > @@ -357,6 +357,8 @@
> >   		interrupts = <0 60 0>;
> >   		clocks = <&clock CLK_I2C2>;
> >   		clock-names = "i2c";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c2_bus>;
> >   		status = "disabled";
> >   	};
> >
> > @@ -368,6 +370,8 @@
> >   		interrupts = <0 61 0>;
> >   		clocks = <&clock CLK_I2C3>;
> >   		clock-names = "i2c";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c3_bus>;
> >   		status = "disabled";
> >   	};
> >
> > @@ -379,6 +383,8 @@
> >   		interrupts = <0 62 0>;
> >   		clocks = <&clock CLK_I2C4>;
> >   		clock-names = "i2c";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c4_bus>;
> >   		status = "disabled";
> >   	};
> >
> > @@ -390,6 +396,8 @@
> >   		interrupts = <0 63 0>;
> >   		clocks = <&clock CLK_I2C5>;
> >   		clock-names = "i2c";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c5_bus>;
> >   		status = "disabled";
> >   	};
> >
> > @@ -401,6 +409,8 @@
> >   		interrupts = <0 64 0>;
> >   		clocks = <&clock CLK_I2C6>;
> >   		clock-names = "i2c";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c6_bus>;
> >   		status = "disabled";
> >   	};
> >
> > @@ -412,6 +422,8 @@
> >   		interrupts = <0 65 0>;
> >   		clocks = <&clock CLK_I2C7>;
> >   		clock-names = "i2c";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&i2c7_bus>;
> >   		status = "disabled";
> >   	};
> >
> >
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
Applied, thanks.

- Kukjin
