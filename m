From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 11 Jun 2013 15:14:15 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGlteDM1OiBBZGQga2VybmVsIG9mdHJl?=
 =?UTF-8?B?ZSBzdXBwb3J0?=
In-Reply-To: <1370948894-757-1-git-send-email-kunadt@schleissheimer.de>
References: <1370948894-757-1-git-send-email-kunadt@schleissheimer.de>
Message-ID: <1370949255.686130093@f257.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds basic support for imx35-based devices to
> the kernel.
> 
> Signed-off-by: Ivo Kunadt <kunadt@schleissheimer.de>
...
> +config MACH_IMX35_DT
> +	bool "Support i.MX35 platforms from device tree"
> +	select SOC_IMX35

> +	select IMX_HAVE_PLATFORM_IMX2_WDT
> +	select IMX_HAVE_PLATFORM_MXC_NAND
> +	select PINCTRL
> +	select PINCTRL_IMX35

On my opinion, this should not be here.

---
