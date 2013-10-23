From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Oct 2013 10:17:29 +0200
Subject: [PATCHv3][ 2/3] arm/dts: Add support for the cpuimx35 board from
 Eukrea and its baseboard.
In-Reply-To: <1382112708-7424-2-git-send-email-denis@eukrea.com>
References: <1382112708-7424-1-git-send-email-denis@eukrea.com>
 <1382112708-7424-2-git-send-email-denis@eukrea.com>
Message-ID: <20131023081729.GP30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

You missed the most important person on Cc: Shawn Guo. He is the one who
applies patches to i.MX.

On Fri, Oct 18, 2013 at 06:11:47PM +0200, Denis Carikli wrote:
> +&ipu {
> +	status = "okay";
> +};
> +
> +&lcdc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdc_1>;
> +	ipu-disp-format = "rgb666";
> +};

Please drop the graphics nodes for now until we have the IPU bindings
sorted out and merged.

Otherwise:

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
