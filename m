From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 29 May 2011 21:16:33 +0200
Subject: [PATCH v2 2/2] ARM: mxs: use gpio-mxs driver by adding platform
	device
In-Reply-To: <1306595374-25178-3-git-send-email-shawn.guo@linaro.org>
References: <1306595374-25178-1-git-send-email-shawn.guo@linaro.org>
	<1306595374-25178-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <201105292116.33862.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 May 2011 17:09:34 Shawn Guo wrote:
> It replaces mach-mxs/gpio with gpio-mxs driver by adding platform
> device for drivers/gpio/gpio-mxs, and then remove the mach-mxs/gpio
> driver.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
