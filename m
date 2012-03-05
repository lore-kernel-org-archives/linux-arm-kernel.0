From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Mar 2012 15:35:41 +0800
Subject: [PATCH 04/20] ARM: imx: convert audmux to a platform driver
In-Reply-To: <20120304190031.GT3852@pengutronix.de>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-5-git-send-email-shawn.guo@linaro.org>
 <20120304190031.GT3852@pengutronix.de>
Message-ID: <20120305073538.GB16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 08:00:31PM +0100, Sascha Hauer wrote:
...
> The audmux is a device completely internal to the i.MX and is registered
> without platform_data. I think we should do the device registration
> somewhere in the SoC specific code and not do it in each board.
> Also we now have platform_device_register_simple, we shouldn't use the
> imx_ variant in new code.
> 
Good point.  Then we do not need to add audmux device board by board.

-- 
Regards,
Shawn
