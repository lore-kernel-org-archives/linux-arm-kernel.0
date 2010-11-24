From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Wed, 24 Nov 2010 07:42:37 -0700
Subject: [PATCHv5 1/3] ARM: imx: Add core definitions for MX53
In-Reply-To: <AANLkTimN1tQee2PywyphPnAdvC8_ASgZud_F=ma_+Bde@mail.gmail.com>
References: <1289842201-3277-1-git-send-email-Dinh.Nguyen@freescale.com>
	<AANLkTimN1tQee2PywyphPnAdvC8_ASgZud_F=ma_+Bde@mail.gmail.com>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA01ED76@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

 

From: Richard Zhao [mailto:linuxzsc at gmail.com] 
Sent: Wednesday, November 24, 2010 7:20 AM
To: Nguyen Dinh-R00091
Cc: linux-kernel at vger.kernel.org; amit.kucheria at canonical.com;
linux at arm.linux.org.uk; s.hauer at pengutronix.de; eric at eukrea.com;
u.kleine-koenig at pengutronix.de; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCHv5 1/3] ARM: imx: Add core definitions for MX53

 

Hi Dinh,

> diff --git a/arch/arm/mach-mx5/crm_regs.h
b/arch/arm/mach-mx5/crm_regs.h
> index c776b9a..51ff9bb 100644
> --- a/arch/arm/mach-mx5/crm_regs.h
> +++ b/arch/arm/mach-mx5/crm_regs.h
> @@ -18,6 +18,9 @@
>  #define MX51_CORTEXA8_BASE     MX51_IO_ADDRESS(MX51_ARM_BASE_ADDR)
>  #define MX51_GPC_BASE          MX51_IO_ADDRESS(MX51_GPC_BASE_ADDR)
>
> +/*MX53*/
> +#define MX53_DPLL4_BASE
MX53_IO_ADDRESS(MX53_PLL3_BASE_ADDR)
> +
>  /* PLL Register Offsets */
>  #define MXC_PLL_DP_CTL                 0x00
>  #define MXC_PLL_DP_CONFIG              0x04

CCM and PLL base address are different between mx53 and mx51. Why do
you both use mx51 base address?



No worries, I have a patch ready for more ugly changes to the crm_regs.h
which include the new CCM and PLL changes.


Thanks
Richard

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101124/a6e3dcff/attachment-0001.html>
