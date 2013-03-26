From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 26 Mar 2013 11:35:44 -0700
Subject: [PATCH 0/2] clk: mxs: mach header cleanup
In-Reply-To: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
References: <1364306374-10481-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130326183544.4014.16613@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Shawn Guo (2013-03-26 06:59:32)
> The series cleans up the mach header inclusion from mxs clk drivers,
> which is another step to multiplatform support.
> 
> Mike,
> 
> The series depends on some mxs platform cleanup patches on my tree.
> May I ask you ACK on the patches to have them go arm-soc tree?
> 
> Shawn
> 

Hi Shawn,

Nice cleanup.

Acked-by: Mike Turquette <mturquette@linaro.org>

> Shawn Guo (2):
>   clk: mxs: get base address from device tree
>   clk: mxs: remove the use of mach level IO accessor
> 
>  arch/arm/boot/dts/imx23.dtsi |    1 +
>  arch/arm/boot/dts/imx28.dtsi |    1 +
>  drivers/clk/mxs/clk-imx23.c  |   37 +++++++++++++++++++++++--------------
>  drivers/clk/mxs/clk-imx28.c  |   38 +++++++++++++++++++++++---------------
>  4 files changed, 48 insertions(+), 29 deletions(-)
> 
> -- 
> 1.7.9.5
