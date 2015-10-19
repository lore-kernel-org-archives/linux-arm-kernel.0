From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Oct 2015 08:49:25 +0200
Subject: [PATCH 0/3] Mediatek EFUSE Support
In-Reply-To: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
References: <1444984751-4572-1-git-send-email-andrew-ct.chen@mediatek.com>
Message-ID: <20151019064925.GF14476@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 16, 2015 at 04:39:08PM +0800, andrew-ct.chen at mediatek.com wrote:
> This patch adds EFUSE support driver which is used by other drivers
> like thermal sensor and HDMI impedance.
> 
> There are some efuses these fuses store things like calibration data,
> speed bins.. etc. Drivers like thermal sensor, HDMI impedance would
> read out this data for configuring the driver.
> 
> Andrew-CT Chen (3):
>   dt-bindings: add document of mediatek efuse driver
>   nvmem: mediatek: Add Mediatek EFUSE driver
>   dts: arm64: Add EFUSE device node

Being the one who motivated using nvmem for the efuses and having
reviewed the first internal version of this driver, this version looks
ok to me.

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
