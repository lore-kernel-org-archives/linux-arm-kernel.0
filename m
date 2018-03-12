From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 12 Mar 2018 10:02:50 +0530
Subject: [PATCH 06/10] ARM64: dts: meson: Remove
 "cooling-{min|max}-level" for CPU nodes
In-Reply-To: <303e6c56-8076-e590-c778-81cb8c0181ed@baylibre.com>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <6c91ebfecf86da98a7682c6d262ff1218a1d7343.1518166039.git.viresh.kumar@linaro.org>
 <303e6c56-8076-e590-c778-81cb8c0181ed@baylibre.com>
Message-ID: <20180312043250.GT6842@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-02-18, 10:03, Neil Armstrong wrote:
> On 09/02/2018 09:58, Viresh Kumar wrote:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of the kernel currently and the max cooling state of
> > a CPU cooling device is found by referring to the cpufreq table instead.
> > 
> > Remove the unused properties from the CPU nodes.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> > index 1448c3dba08e..658215c9822c 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
> > @@ -209,14 +209,10 @@
> >  };
> >  
> >  &cpu0 {
> > -	cooling-min-level = <0>;
> > -	cooling-max-level = <6>;
> >  	#cooling-cells = <2>;
> >  };
> >  
> >  &cpu4 {
> > -	cooling-min-level = <0>;
> > -	cooling-max-level = <4>;
> >  	#cooling-cells = <2>;
> >  };
> >  
> > 
> 
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Is Kevin going to apply these for 4.17 ?

-- 
viresh
