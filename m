From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2012 14:10:45 -0300
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Wed, Jun 13, 2012 at 9:34 AM, Richard Zhao
<richard.zhao@freescale.com> wrote:
> The work is based on ?ci13xxx rework done by Alexander Shishkin.
>
> Status:
> ?- this version only support host
> ?- usbotg controler works at host role
>
> Changes since last version:
> ?- collect ack received.
>
> Richard Zhao (13):
> ?usb: otg: add notify_connect/notify_disconnect callback
> ?USB: move transceiver from ehci_hcd and ohci_hcd to hcd and rename it
> ? ?as phy
> ?USB: notify phy when root hub port connect change
> ?usb: chipidea: permit driver bindings pass phy pointer
> ?usb: otg: add basic mxs phy driver support
> ?usb: chipidea: add imx platform driver
> ?ARM: imx6q: correct device name of usbphy and usb controller clock
> ? ?export
> ?ARM: imx6q: add config-on-boot gpios
> ?ARM: imx6q: add usbphy clocks
> ?ARM: imx6q: disable usb charger detector
> ?ARM: dts: imx6q-sabrelite: add usb devices
> ?ARM: mxs: clk_register_clkdev mx28 usb clocks
> ?ARM: dts: imx28-evk: add usb devices

I am trying your patch series on a mx28evk and I am not able to have
my USB pen drive detected.

I tried enabling all the required config options in .config.

Could you please share your .config?

Thanks,

Fabio Estevam
