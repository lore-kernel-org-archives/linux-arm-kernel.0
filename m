From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 May 2014 11:34:52 +0900
Subject: [PATCH] arm: dts: exynos4412-trats2: rename alias for i2c_ak8975
 label
In-Reply-To: <53594496.4010607@samsung.com>
References: <534D4143.3050801@samsung.com> <53594496.4010607@samsung.com>
Message-ID: <098d01cf68d3$c2420b10$46c62130$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Tomasz,
> 
> On 15.04.2014 16:25, Tomasz Stanislawski wrote:
> > The i2c_ak8975 controler uses label i2c8.
> > This alias is already used for I2C controller 8 defined
> > in file arch/arm/boot/dts/exynos4.dtsi.
> >
> > This patch renames a label for i2c_ak8975 to i2c9.
> >
> > Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
> > ---
> >   arch/arm/boot/dts/exynos4412-trats2.dts |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts
> b/arch/arm/boot/dts/exynos4412-trats2.dts
> > index c16b315..5add765 100644
> > --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> > +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> > @@ -20,7 +20,7 @@
> >   	compatible = "samsung,trats2", "samsung,exynos4412",
> "samsung,exynos4";
> >
> >   	aliases {
> > -		i2c8 = &i2c_ak8975;
> > +		i2c9 = &i2c_ak8975;
> >   	};
> >
> >   	memory {
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-samsung-
> soc" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Seems reasonable.
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
Applied, thanks.

- Kukjin
