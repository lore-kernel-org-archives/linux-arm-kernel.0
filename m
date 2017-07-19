From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 19 Jul 2017 17:40:06 +0200
Subject: [PATCH 1/2] mtd: nand: pxa3xx_nand: enable building on mvebu
 64-bit platforms
In-Reply-To: <20170719153126.16905-2-gregory.clement@free-electrons.com>
References: <20170719153126.16905-1-gregory.clement@free-electrons.com>
 <20170719153126.16905-2-gregory.clement@free-electrons.com>
Message-ID: <20170719174006.1ca20652@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 19 Jul 2017 17:31:25 +0200, Gregory CLEMENT wrote:

>  config MTD_NAND_PXA3xx
>  	tristate "NAND support on PXA3xx and Armada 370/XP"
> -	depends on PXA3xx || ARCH_MMP || PLAT_ORION
> +	depends on PXA3xx || ARCH_MMP || PLAT_ORION  || ARCH_MVEBU

                                                   ^^^

Stupid minor nit: there are two spaces here, there should be one. No
need to send a v2 just for this, I'm sure Boris will happily fix this
when applying :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
