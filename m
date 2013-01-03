From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 3 Jan 2013 13:52:01 -0600
Subject: [PATCH v4 14/19] ARM: remove unneeded vic.h includes
In-Reply-To: <1357235668-9450-15-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-15-git-send-email-robherring2@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206D69AB47F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 03, 2013 10:54 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Numerous includes of asm/hardware/vic.h aren't needed, so remove them.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Hubert Feurstein <hubert.feurstein@contec.at>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: patches at opensource.wolfsonmicro.com
> ---
>  arch/arm/mach-ep93xx/adssphere.c              |    1 -
>  arch/arm/mach-ep93xx/edb93xx.c                |    1 -
>  arch/arm/mach-ep93xx/gesbc9312.c              |    1 -
>  arch/arm/mach-ep93xx/micro9.c                 |    1 -
>  arch/arm/mach-ep93xx/simone.c                 |    1 -
>  arch/arm/mach-ep93xx/snappercl15.c            |    1 -
>  arch/arm/mach-ep93xx/ts72xx.c                 |    1 -
>  arch/arm/mach-ep93xx/vision_ep9307.c          |    1 -

For ep93xx:

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
