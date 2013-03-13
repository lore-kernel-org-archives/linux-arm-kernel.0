From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 13 Mar 2013 09:05:14 +0530
Subject: [PATCH 3/4] clk: samsung: always allocate the clk_table
In-Reply-To: <513F321E.1020703@samsung.com>
References: <201303120042.09633.heiko@sntech.de>
 <201303120044.29499.heiko@sntech.de>
 <CAJuYYwT183EcZZ20P8D7AP34CwXfKYLzsmZdoJz1ny7XznzyAg@mail.gmail.com>
 <513F1037.3080107@samsung.com>
 <CAJuYYwRDv4ULqXQOXmTsGfqVopt6XPR+XXb-pPZ35+pC7kUN3A@mail.gmail.com>
 <513F321E.1020703@samsung.com>
Message-ID: <CAK9yfHwQreXt+tXLz7YsNqDXwaT19U2KJvqmd-tPTx_E6nKBsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> So except Universal_c210 and Nuri the only ones not supporting booting
> from DT are these two simple boards, which seem to be maintained by
> Samsung:
>
> arch/arm/mach-exynos/mach-smdk4x12.c

SMDK4412 is already supported through DT (exynos4412-smdk4412.dts) as
you already pointed out. I am not sure if anyone is using SMDK4212.
Even if it is required, one can easily add a dts file for that board
as DT support for 4x12 already exists.

arch/arm/boot/dts/exynos4x12.dtsi
arch/arm/boot/dts/exynos4x12-pinctrl.dtsi

-- 
With warm regards,
Sachin
