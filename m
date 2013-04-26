From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 26 Apr 2013 10:13:59 +0200
Subject: [PATCH 20/21] MFD: ab8500: export ab8500_gpadc_sw_hw_convert
 properly
In-Reply-To: <1366734653-488286-21-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
 <1366734653-488286-21-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkda6GpxUf8oPw74A08D0RJKZWir4hqXLjz-fe8Kq02vmDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 6:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> Apparently the ab8500_gpadc_sw_hw_convert function got renamed
> from ab8500_gpadc_convert to ab8500_gpadc_sw_hw_convert in
> commit 734823462 "mfd: ab8500-gpadc: Add gpadc hw conversion",
> but the export for this function did not get changed at the
> same time, causing this allyesconfig error:
>
> ERROR: "ab8500_gpadc_sw_hw_convert" [drivers/hwmon/ab8500.ko] undefined!
>
> This patch fixes the export.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: M'boumba Cedric Madianga <cedric.madianga@stericsson.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mattias WALLIN <mattias.wallin@stericsson.com>
> Cc: Michel JAOUEN <michel.jaouen@stericsson.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Sam -> please pick this...

Yours,
Linus Walleij
