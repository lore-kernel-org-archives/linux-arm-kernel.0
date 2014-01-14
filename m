From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Jan 2014 15:20:36 +0100
Subject: [PATCH] ARM: s3c24xx: explicit dependency on <plat/gpio-cfg.h>
In-Reply-To: <1389708788-18331-1-git-send-email-linus.walleij@linaro.org>
References: <1389708788-18331-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2340755.WhXRgu2emH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. Januar 2014, 15:13:08 schrieb Linus Walleij:
> Previously the custom GPIO header for the S3C24xx would in turn
> bring in the custom pin control implementation from
> <plat/gpio-cfg.h>. This is not good as it mixes up two
> subsystems and makes the dependencies hard to track. Make
> the dependency explicit by explicitly including the pin
> control header where needed.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Maintainers: this builds on top of the previous patch moving
> headers back to <mach/*>. This will also boil in linux-next,
> ACKs appreciated.
> ---

Acked-by: Heiko Stuebner <heiko@sntech.de>
