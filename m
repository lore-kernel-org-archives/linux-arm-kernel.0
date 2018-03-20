From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 20 Mar 2018 09:43:18 +0800
Subject: [PATCH 07/10] ARM: dts: gemini: Remove "cooling-{min|max}-level"
 for gpio-fan node
In-Reply-To: <20180312043533.GU6842@vireshk-i7>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <01ddf0ac8962feb63e8871a2c2c3498c763f649b.1518166039.git.viresh.kumar@linaro.org>
 <20180312043533.GU6842@vireshk-i7>
Message-ID: <20180320014318.g7koh7ld3seucg4c@vireshk-mac-ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-03-18, 10:05, Viresh Kumar wrote:
> On 09-02-18, 14:28, Viresh Kumar wrote:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of the kernel currently and the max cooling state of
> > gpio-fan cooling device is found by referring to the
> > "gpio-fan,speed-map" instead.
> > 
> > Remove the unused properties from the gpio-fan node.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm/boot/dts/gemini-dlink-dns-313.dts | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/gemini-dlink-dns-313.dts b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> > index 08568ce24d06..727d16eb02d9 100644
> > --- a/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> > +++ b/arch/arm/boot/dts/gemini-dlink-dns-313.dts
> > @@ -78,8 +78,6 @@
> >  		gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>,
> >  			<&gpio0 12 GPIO_ACTIVE_HIGH>;
> >  		gpio-fan,speed-map = <0 0>, <3000 1>, <6000 2>;
> > -		cooling-min-level = <0>;
> > -		cooling-max-level = <2>;
> >  		#cooling-cells = <2>;
> >  	};
> >  
> 
> @Linus: Can you please pick this one for 4.17 ?

@Arnd/Olof: Can you please pick this one up as well ?

-- 
viresh
