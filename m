From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Mar 2014 12:04:18 -0700
Subject: [PATCH 0/4] sunxi clock fixes
In-Reply-To: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
References: <1395253173-30437-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20140319190418.30995.17661@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2014-03-19 11:19:29)
> Hi everyone,
> 
> This is a small series of patches fixing a couple of bugs that are 
> present on the sunxi clock driver. Mike, are there any chances we can
> take these during the 3.15 merge window or -rc period?

I can take these towards 3.15. Do you want me to take the dts patch too?

Regards,
Mike

> 
> Cheers,
> 
> Emilio
> 
> Emilio L?pez (4):
>   clk: sunxi: fix A20 PLL4 calculation
>   ARM: sun7i: fix PLL4 clock and add PLL8
>   clk: sunxi: fix some calculations
>   clk: sunxi: fix thinko in comment
> 
>  arch/arm/boot/dts/sun7i-a20.dtsi | 10 +++++++++-
>  drivers/clk/sunxi/clk-sunxi.c    | 15 +++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> -- 
> 1.9.0
> 
