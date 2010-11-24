From: linuxzsc@gmail.com (Richard Zhao)
Date: Wed, 24 Nov 2010 21:20:26 +0800
Subject: [PATCHv5 1/3] ARM: imx: Add core definitions for MX53
In-Reply-To: <1289842201-3277-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1289842201-3277-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <AANLkTimN1tQee2PywyphPnAdvC8_ASgZud_F=ma_+Bde@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

> diff --git a/arch/arm/mach-mx5/crm_regs.h b/arch/arm/mach-mx5/crm_regs.h
> index c776b9a..51ff9bb 100644
> --- a/arch/arm/mach-mx5/crm_regs.h
> +++ b/arch/arm/mach-mx5/crm_regs.h
> @@ -18,6 +18,9 @@
> ?#define MX51_CORTEXA8_BASE ? ? MX51_IO_ADDRESS(MX51_ARM_BASE_ADDR)
> ?#define MX51_GPC_BASE ? ? ? ? ?MX51_IO_ADDRESS(MX51_GPC_BASE_ADDR)
>
> +/*MX53*/
> +#define MX53_DPLL4_BASE ? ? ? ? ? ? ? ?MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
> +
> ?/* PLL Register Offsets */
> ?#define MXC_PLL_DP_CTL ? ? ? ? ? ? ? ? 0x00
> ?#define MXC_PLL_DP_CONFIG ? ? ? ? ? ? ?0x04

CCM and PLL base address are different between mx53 and mx51. Why do
you both use mx51 base address?

Thanks
Richard
