From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Jan 2013 21:53:17 +0000
Subject: [PATCH v4 14/19] ARM: remove unneeded vic.h includes
In-Reply-To: <1357235668-9450-15-git-send-email-robherring2@gmail.com>
References: <1357235668-9450-1-git-send-email-robherring2@gmail.com>
 <1357235668-9450-15-git-send-email-robherring2@gmail.com>
Message-ID: <201301032153.17476.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 January 2013, Rob Herring wrote:
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
