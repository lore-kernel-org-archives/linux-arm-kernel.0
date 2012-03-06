From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 6 Mar 2012 12:26:08 -0300
Subject: I.MX35 PDK
In-Reply-To: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A26@MEP-EXCH.meprolight.com>
References: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A26@MEP-EXCH.meprolight.com>
Message-ID: <4F562C90.6090103@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Fabio Estevam
