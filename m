From: vigneshr@ti.com (Vignesh R)
Date: Tue, 10 Oct 2017 18:11:31 +0530
Subject: [RESEND PATCH 0/3] K2G: Add support for PWM ECAP
In-Reply-To: <20170919061551.11981-1-vigneshr@ti.com>
References: <20170919061551.11981-1-vigneshr@ti.com>
Message-ID: <d8a7bec5-27df-d713-bff5-d70d946f19f7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 19 September 2017 11:45 AM, Vignesh R wrote:
> 
> This series adds support for TI ECAP PWM IP present in 66AK2G SoC.
> Resending based on today's linux-next.
> 
> 
> Vignesh R (3):
>   ARM: dts: keystone-k2g: Add ECAP PWM DT nodes
>   ARM: dts: keystone-k2g-evm: Enable PWM ECAP0
>   ARM: configs: keystone: Enable TIECAP PWM driver
> 
>  arch/arm/boot/dts/keystone-k2g-evm.dts | 12 ++++++++++++
>  arch/arm/boot/dts/keystone-k2g.dtsi    | 20 ++++++++++++++++++++
>  arch/arm/configs/keystone_defconfig    |  2 ++
>  3 files changed, 34 insertions(+)
> 

Gentle ping on the series...

-- 
Regards
Vignesh
