From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Jun 2011 22:20:14 -0700
Subject: [PATCH v2 4/4] ARM: mxc: remove plat-mxc/gpio driver
In-Reply-To: <1306985632-18820-5-git-send-email-shawn.guo@linaro.org>
References: <1306985632-18820-1-git-send-email-shawn.guo@linaro.org>
	<1306985632-18820-5-git-send-email-shawn.guo@linaro.org>
Message-ID: <BANLkTimX5moosFQbc_37-E+rOxqSwAm7jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 1, 2011 at 8:33 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> With all users of plat-mxc/gpio migrated to drivers/gpio/gpio-mxc,
> plat-mxc/gpio can be removed now. ?And plat-mxc/include/mach/gpio.h
> can also be cleaned up as below.
>
> ?* Remove the helper macros for gpio ports definition
> ?* Move "struct mxc_gpio_port" into drivers/gpio/gpio-mxc.c, as it's
> ? not needed to be public at all
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Olof Johansson <olof@lixom.net>
