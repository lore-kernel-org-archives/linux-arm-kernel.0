From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 16:05:43 +0800
Subject: [alsa-devel] [PATCH 00/34] i.MX multi-platform support
In-Reply-To: <20120918075213.GD24458@pengutronix.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <20120918075213.GD24458@pengutronix.de>
Message-ID: <20120918080541.GA6377@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 09:52:13AM +0200, Sascha Hauer wrote:
> I just had a look at the remaining initcalls in arch-imx. Most of them
> are protected with a cpu_is_*, but this one should be fixed before i.MX
> is enabled for multi platform:
> 
> arch/arm/mach-imx/devices/devices.c:48:core_initcall(mxc_device_init);
> 
Ah, I missed that.  Thanks for reminding, Sascha.

Shawn
