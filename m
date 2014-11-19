From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 17:15:47 +0100
Subject: [PATCH RESEND 0/4] ARM: at91: remove at91sam9g45/9m10 legacy
 board support
In-Reply-To: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <546CC233.6090605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2014 17:07, Boris Brezillon :
> Hello,
> 
> This series adds DT support for the TRNG (True Random Generator) block and
> adds missing trng nodes to dtsi files.

Nitpicking: subject of this cover letter seems not good ;-)

Herbert, do you think you can take this series yourself or do I have to
take it?

Bye,

> Boris Brezillon (4):
>   hwrng: atmel: use clk_prepapre_enable/_disable_unprepare
>   hwrng: atmel: add DT support
>   hwrng: atmel: Add TRNG DT binding doc
>   ARM: at91/dt: add trng node
> 
>  Documentation/devicetree/bindings/hwrng/atmel-trng.txt | 16 ++++++++++++++++
>  arch/arm/boot/dts/at91sam9g45.dtsi                     |  7 +++++++
>  drivers/char/hw_random/Kconfig                         |  2 +-
>  drivers/char/hw_random/atmel-rng.c                     | 15 +++++++++++----
>  4 files changed, 35 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwrng/atmel-trng.txt
> 


-- 
Nicolas Ferre
