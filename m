From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Mar 2014 08:37:40 -0300
Subject: [PATCH v2][ 8/8] ARM: imx_v4_v5_defconfig: Enable drivers for
 i.MX25/i.MX35 USB support.
In-Reply-To: <1394535304-10240-8-git-send-email-denis@eukrea.com>
References: <1394535304-10240-1-git-send-email-denis@eukrea.com>
 <1394535304-10240-8-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5A8bhUj_OKk+y=JT=XFhpjN4dZtA35OzsJLgTQ0jhaO0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Tue, Mar 11, 2014 at 7:55 AM, Denis Carikli <denis@eukrea.com> wrote:

>  CONFIG_USB_EHCI_MXC=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_CHIPIDEA=y
> +CONFIG_USB_CHIPIDEA_UDC=y
> +CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_NOP_USB_XCEIV=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_ETH=m
> +CONFIG_USB_MASS_STORAGE=m

I prefer the way you did in the previous version: CONFIG_USB_STORAGE=y

Regards,

Fabio Estevam
