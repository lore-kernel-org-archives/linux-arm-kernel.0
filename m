From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Dec 2016 09:57:43 +0100
Subject: [PATCH 1/3] ARM: dts: at91: add dma1 definition to sama5d2
In-Reply-To: <20161201104949.23985-1-nicolas.ferre@atmel.com>
References: <20161201104949.23985-1-nicolas.ferre@atmel.com>
Message-ID: <20161207085743.qlomgd4ly54q5oah@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2016 at 11:49:47 +0100, Nicolas Ferre wrote :
> The sama5d2 SoC has a second DMA controller and can be used just like DMA0.
> By default both DMA controllers are configured as "Secure" in
> MATRIX_SPSELR so we can use whichever we want in a "single Secure World"
> configuration.
> Surprisingly the DMA1 has a lower address than DMA0. To avoid confusion
> place it after DMA0 node anyway.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/boot/dts/sama5d2.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

All applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
