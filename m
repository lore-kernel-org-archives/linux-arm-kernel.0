From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Jan 2015 15:25:38 -0600
Subject: [PATCH] ARM: omap2plus_defconfig: Enable misc options for
 BeagleBoard-X15 platform
In-Reply-To: <1420751680-21230-1-git-send-email-nm@ti.com>
References: <1420751680-21230-1-git-send-email-nm@ti.com>
Message-ID: <20150108212538.GU31926@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 08, 2015 at 03:14:40PM -0600, Nishanth Menon wrote:
> @@ -205,6 +206,7 @@ CONFIG_PINCTRL_SINGLE=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_TWL4030=y
> +CONFIG_GPIO_PALMAS=y

other than the power button, do you have anything else attached to a
palmas GPIO ? We might not need this for boot.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/6eebc262/attachment.sig>
