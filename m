From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 31 Mar 2011 12:44:16 +0300
Subject: [PATCH 7/7] MTD : add GPMI driver in the config and Makefile
In-Reply-To: <1300240521-4344-8-git-send-email-b32955@freescale.com>
References: <1300240521-4344-1-git-send-email-b32955@freescale.com>
	<1300240521-4344-8-git-send-email-b32955@freescale.com>
Message-ID: <1301564656.2828.24.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-16 at 09:55 +0800, Huang Shijie wrote:
> +config MTD_NAND_GPMI_NFC
> +        bool "GPMI NAND Flash Controller driver"
> +        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
> +	select MTD_PARTITIONS
> +        help
> +	 Enables NAND Flash support for IMX23 or IMX28.
> +	 The GPMI controller is very powerful, with the help of BCH
> +	 module, it can do the hardware ECC. The GPMI supports several
> +	 NAND flashs at the same time.

Please, fix the indentation here. Look at other entries in this file and
format the same way. Also, a bit write more text. Use word "freescale"
somewhere.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
