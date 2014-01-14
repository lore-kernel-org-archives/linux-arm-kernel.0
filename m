From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Jan 2014 15:19:36 +0100
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <2305953.5h9ERW0lIo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 14. Januar 2014, 14:53:38 schrieb Linus Walleij:
> When refactoring and breaking out the includes for the
> machine-specific GPIO configuration, two files were created
> in <linux/platform_data/gpio-samsung-s3c[24|64]xx.h>, but as
> that namespace shall be used for defining data exchanged
> between machines and drivers, using it for these broad macros
> and config settings is wrong.
> 
> Move the headers back into the machine-local
> <mach/gpio-samsung.h> file and think about the next step.
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
> Maintainers (Kukjin especially) - it'd be nice with a speedy
> ACK if this looks OK. I will put it into linux-next immediately
> so things are in order and smoketested for the merge window.
> ---

Acked-by: Heiko Stuebner <heiko@sntech.de>
