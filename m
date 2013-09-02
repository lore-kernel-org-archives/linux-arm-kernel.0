From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 2 Sep 2013 11:25:50 +0200
Subject: [PATCH v3 0/7] ARM: imx27 pinctrl
In-Reply-To: <1378020488-21129-1-git-send-email-mpa@pengutronix.de>
References: <1378020488-21129-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130902092550.GY30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 01, 2013 at 09:28:01AM +0200, Markus Pargmann wrote:
> Hi,
> 
> this series implements a imx27 pinctrl driver. imx1/21/27 have a register
> format that is not compatible with the rest of imx series processors. The
> series adds a imx1 core driver for the different register layout.
> 
> Regards,
> 
> Markus
> 
> Changes since v2:
>  - Some fixes in dts files and documentation
> 
> Changes since v1:
>  - Removed changes of gpio-mxc driver
>  - imx and imx1-core drivers are completely seperated now
>  - Splitted DT pinctrl entries into imx27.dtsi and board files
>  - Other style changes

>From my side this looks ok now.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
