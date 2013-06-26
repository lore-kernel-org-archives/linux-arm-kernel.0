From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 26 Jun 2013 01:59:22 +0000
Subject: [PATCH 0/3] ARM: at91/DT: enable SPI for more SoCs
In-Reply-To: <cover.1372069834.git.nicolas.ferre@atmel.com>
References: <cover.1372069834.git.nicolas.ferre@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641687DF77C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Nicolas Ferre [mailto:nicolas.ferre at atmel.com]
> Sent: 2013?6?24? 18:35
> To: Jean-Christophe PLAGNIOL-VILLARD; Desroches, Ludovic; Yang, Wenyou;
> Shen, Voice; Wu, Josh
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ferre,
> Nicolas
> Subject: [PATCH 0/3] ARM: at91/DT: enable SPI for more SoCs
> 
> This little series is for enabling the support of SPI on at91sam9n12 and
> sama5d3 families.
> 
> Nicolas Ferre (3):
>   ARM: at91/DT: fix SPI compatibility string
>   ARM: at91/DT: sama5d3: add SPI DMA client infos
>   ARM: at91/DT: at91sam9n12: add SPI DMA client infos
> 
>  arch/arm/boot/dts/at91sam9n12.dtsi |  6 ++++++
>  arch/arm/boot/dts/sama5d3.dtsi     | 10 ++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> --
> 1.8.2.2

Tested on sama5d34ek, Linux-next: next-20130624

Tested by Wenyou Yang <wenyou.yang@atmel.com>
