From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 6 Nov 2013 13:49:06 +0100
Subject: [PATCH v6 0/8] ARM: imx27 pinctrl
In-Reply-To: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
References: <1382950843-26066-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20131106124906.GG15098@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Oct 28, 2013 at 10:00:35AM +0100, Markus Pargmann wrote:
> Hi,
> 
> v6 updates the binding documentation.
> 
> this series implements a imx27 pinctrl driver. imx1/21/27 have a register
> format that is not compatible with the rest of imx series processors. The
> series adds a imx1 core driver for the different register layout.
> 
> Regards,
> 
> Markus
> 
> 
> Markus Pargmann (8):
>   pinctrl: imx1 core driver
>   pinctrl: imx27: imx27 pincontrol driver
>   ARM: dts: imx27 pin functions
>   ARM: dts: imx27 pinctrl
>   ARM: dts: imx27 phyCARD-S pinctrl
>   ARM: dts: imx27 phycore move uart1 to rdk
>   ARM: dts: imx27 phycore pinctrl
>   ARM: imx27: enable pinctrl

Linus applied the first two patches. Could you take the others?

Thanks,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
