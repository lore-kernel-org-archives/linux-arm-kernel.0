From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 29 Nov 2017 19:27:44 +0100
Subject: [REBASED PATCH] ARM: dts: exynos: fix property values of
 LDO15/17 for ODROID-XU3/4
In-Reply-To: <20171128001501.12740-1-tobetter@gmail.com>
References: <20171128001501.12740-1-tobetter@gmail.com>
Message-ID: <20171129182744.6brikrehd6sejwab@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 07:15:01PM -0500, Dongjin Kim wrote:
> Looking at the schematic, LDO15 and LDO17 are tied as a power source of a
> builtin network chipset. The voltage on LDO15 is corrected to 3.3V and the
> name of LDO17 is corrected to "vdd_ldo17".
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Thanks, applied.

Best regards,
Krzysztof
