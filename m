From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 16 Jul 2013 16:49:41 +0800
Subject: [PATCH 12/22] video: backlight: Add GPIO Backlight driver.
In-Reply-To: <1373900227-341-13-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-13-git-send-email-denis@eukrea.com>
Message-ID: <20130716084926.GJ30067@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:56:57PM +0200, Denis Carikli wrote:
> This initial driver uses and depends on DT bindings.
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../bindings/video/backlight/gpio-backlight.txt    |   18 ++
>  drivers/video/backlight/Kconfig                    |    7 +
>  drivers/video/backlight/Makefile                   |    1 +
>  drivers/video/backlight/gpio_bl.c                  |  226 ++++++++++++++++++++
>  4 files changed, 252 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-backlight.txt
>  create mode 100644 drivers/video/backlight/gpio_bl.c

Please send the patch to subsystem mailing list and maintainers.

Shawn
