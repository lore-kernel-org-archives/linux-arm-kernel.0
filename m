From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Aug 2015 12:25:56 +0200
Subject: [PATCH] ARM/fb: ep93xx: switch framebuffer to use modedb only
In-Reply-To: <1439306238-30655-1-git-send-email-linus.walleij@linaro.org>
References: <1439306238-30655-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150813102556.GX30160@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 05:17:18PM +0200, Linus Walleij wrote:
> All the EP93xx boards exclusively use modedb to look up video
> modes from the command line. Root out the parametrization of
> custom video modes from the platform data and board files
> and simplify the driver.
> 
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC maintainers, please apply this directly to the
> EP93xx/cleanup branch now that I have Tomi's ACK.

Applied to next/cleanup, thanks.


-Olof
