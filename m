From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 20 Oct 2016 15:28:33 -0700
Subject: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
References: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161020222833.GA27421@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 04:49:42PM -0300, Javier Martinez Canillas wrote:
> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
> 
> So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
> since the reported uevent MODALIAS to user-space will be the OF one.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
