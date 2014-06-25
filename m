From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 25 Jun 2014 12:37:20 +0200
Subject: [PATCH 0/3] ARM: at91/dt: clock fixes
In-Reply-To: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1402667001-11207-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <53AAA660.1030001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/2014 15:43, Alexandre Belloni :
> Some clocks were not properly defined:
>  - ICPLL and OUT values for PLLA got mixed on sam9x5 and sam9n12
>  - mainck was not correctly defined on sam9261
> 
> Alexandre Belloni (3):
>   ARM: at91/dt: sam9x5: correct PLLA ICPLL and OUT values
>   ARM: at91/dt: sam9n12: correct PLLA ICPLL and OUT values
>   ARM: at91/dt: sam9261: correctly define mainck

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and added to the at91-3.16-fixes branch.

Thanks,

>  arch/arm/boot/dts/at91sam9261.dtsi | 10 ++++++++--
>  arch/arm/boot/dts/at91sam9n12.dtsi |  4 ++--
>  arch/arm/boot/dts/at91sam9x5.dtsi  |  4 ++--
>  3 files changed, 12 insertions(+), 6 deletions(-)
> 


-- 
Nicolas Ferre
