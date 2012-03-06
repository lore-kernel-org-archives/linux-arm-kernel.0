From: alexg@meprolight.com (Alex Gershgorin)
Date: Tue, 6 Mar 2012 17:35:51 +0200
Subject: I.MX35 PDK
In-Reply-To: <4F562C90.6090103@freescale.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A27@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Fabio :-) 

-----Original Message-----
From: Fabio Estevam [mailto:fabio.estevam at freescale.com] 
Sent: Tuesday, March 06, 2012 5:26 PM
To: Alex Gershgorin
Cc: linux-arm-kernel at lists.infradead.org; kernel at pengutronix.de; festevam at gmail.com
Subject: Re: I.MX35 PDK

Alex Gershgorin wrote:
> Hi Fabio,
> 
>  
> 
> How I can get information about accesses to CMOS_RST_B and CSI_PWDN bits
> of MC9S08DZ60 processor.
> 
> I need address of this register and bits mapping in this register.  

You can check Freescale kernel to get this information:
http://opensource.freescale.com/git?p=imx/linux-2.6-imx.git;a=shortlog;h=refs/heads/imx_2.6.31

Search for "pmic_gpio_set_bit_val"

Wu Guoxing submitted the mc9s08dz60 driver patch to mainline:
drivers/gpio/gpio-mc9s08dz60.c

Regards,

Alex Gershgorin
