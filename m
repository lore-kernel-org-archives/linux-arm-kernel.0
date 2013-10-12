From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 12 Oct 2013 15:34:27 +0800
Subject: [PATCH] ARM: mxs_defconfig: Turn off CONFIG_DEBUG_GPIO
In-Reply-To: <1381288239-21678-1-git-send-email-festevam@gmail.com>
References: <1381288239-21678-1-git-send-email-festevam@gmail.com>
Message-ID: <20131012073425.GC21305@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 12:10:39AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Having CONFIG_DEBUG_GPIO=y leads to several debug messages polluting kernel log:
> 
> [    0.580325] of_get_named_gpio_flags: can't parse gpios property of node '/regulators/3p3v[0]'
> [    0.581185] 3P3V: 3300 mV 
> [    0.584827] of_get_named_gpio_flags exited with status 124
> [    0.585852] vddio-sd0: 3300 mV 
> [    0.590023] of_get_named_gpio_flags exited with status 79
> [    0.590770] fec-3v3: 3300 mV 
> [    0.594805] of_get_named_gpio_flags exited with status 105
> [    0.595491] usb0_vbus: 5000 mV 
> [    0.599687] of_get_named_gpio_flags exited with status 104
> [    0.600380] usb1_vbus: 5000 mV 
> [    0.604463] of_get_named_gpio_flags exited with status 126
> [    0.605153] lcd-3v3: 3300 mV 
> [    0.608970] of_get_named_gpio_flags exited with status 77
> 
> Turn this option off, as these messages are not really useful for normal usage.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
