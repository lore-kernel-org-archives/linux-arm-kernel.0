From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Apr 2018 16:55:23 +0200
Subject: [PATCH] ARM: s3c24xx: jive: Fix some GPIO names
In-Reply-To: <20180423115700.13038-1-linus.walleij@linaro.org>
References: <20180423115700.13038-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a3q3ZNPpD8KGejYTZ_iuJUue99OmqP3eK8JLGEUQSS=9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2018 at 1:57 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> One of the bitbanged SPI hosts had wrongly named GPIO lines due to
> sloppiness by yours truly.
>
> Cc: arm at kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC people:
> Please apply this directly for fixes if it is OK with
> everyone.

Applied to fixes, thanks!

        Arnd
