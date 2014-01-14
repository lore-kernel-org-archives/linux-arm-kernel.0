From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jan 2014 15:11:47 +0100
Subject: [PATCH] ARM: S3C[24|64]xx: move includes back under <mach/> scope
In-Reply-To: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
References: <1389707618-17011-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3526096.UdPXMDriCf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 January 2014 14:53:38 Linus Walleij wrote:
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
