From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Mar 2013 15:37:22 +0100
Subject: [PATCH 0/4] ARM: at91: little DT fixes
In-Reply-To: <cover.1363960549.git.nicolas.ferre@atmel.com>
References: <cover.1363960549.git.nicolas.ferre@atmel.com>
Message-ID: <20130325143722.GD20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:23 Fri 22 Mar     , Nicolas Ferre wrote:
> Hi,
> 
> Here are some little fixes found while adding device tree boards.
> I plan to request a pull on this material early next week.
> 
> 
> Nicolas Ferre (4):
>   ARM: at91/dt: fix macb node declaration
>   ARM: at91/trivial: typos in compatible property
>   ARM: at91/trivial: fix model name for SAM9G15-EK
>   ARM: at91: remove partial parameter in bootargs for at91sam9x5ek.dtsi

on all

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

> 
>  arch/arm/boot/dts/at91sam9g15.dtsi  |  2 +-
>  arch/arm/boot/dts/at91sam9g15ek.dts |  2 +-
>  arch/arm/boot/dts/at91sam9g25.dtsi  |  2 +-
>  arch/arm/boot/dts/at91sam9g25ek.dts |  9 +++++++++
>  arch/arm/boot/dts/at91sam9g35.dtsi  |  2 +-
>  arch/arm/boot/dts/at91sam9g35ek.dts |  9 +++++++++
>  arch/arm/boot/dts/at91sam9x25.dtsi  |  2 +-
>  arch/arm/boot/dts/at91sam9x25ek.dts | 14 ++++++++++++++
>  arch/arm/boot/dts/at91sam9x35.dtsi  |  2 +-
>  arch/arm/boot/dts/at91sam9x35ek.dts |  9 +++++++++
>  arch/arm/boot/dts/at91sam9x5ek.dtsi |  7 +------
>  11 files changed, 48 insertions(+), 12 deletions(-)
> 
> -- 
> 1.8.0
> 
