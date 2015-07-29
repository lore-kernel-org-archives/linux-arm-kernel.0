From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 29 Jul 2015 11:57:52 +0300
Subject: [PATCH 0/4] omap: Fix broken pbias device creation
In-Reply-To: <1437999401-3519-1-git-send-email-kishon@ti.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
Message-ID: <55B89590.6000109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2015 03:16 PM, Kishon Vijay Abraham I wrote:
> pbias device creation got broken once SCM cleanup got merged.
> This patch series re-enables device creation by adding
> "simple-bus" in the compatible property of the syscon
> dt node.
>
> validated this series in DRA72, OMAP4 PANDA and OMAP5 UEVM
> boards.
>
> Kishon Vijay Abraham I (4):
>    ARM: dts: omap24xx: Fix broken pbias device creation
>    ARM: dts: OMAP4: Fix broken pbias device creation
>    ARM: dts: OMAP5: Fix broken pbias device creation
>    ARM: dts: dra7: Fix broken pbias device creation
>
>   arch/arm/boot/dts/dra7.dtsi     |    2 +-
>   arch/arm/boot/dts/omap2430.dtsi |    3 ++-
>   arch/arm/boot/dts/omap4.dtsi    |    3 ++-
>   arch/arm/boot/dts/omap5.dtsi    |    3 ++-
>   4 files changed, 7 insertions(+), 4 deletions(-)
>

For dra7-evm:
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
