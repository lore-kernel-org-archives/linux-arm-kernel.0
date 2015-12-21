From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 21 Dec 2015 21:25:40 +0800
Subject: [PATCH] ARM: imx: select SRC for i.MX7
In-Reply-To: <3611827.5qPn4xd4c4@wuerfel>
References: <3611827.5qPn4xd4c4@wuerfel>
Message-ID: <20151221132540.GB18410@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 04:40:26PM +0100, Arnd Bergmann wrote:
> The i.MX7 Kconfig option had a couple of missing select lines that
> I fixed already, but I missed HAVE_IMX_SRC:
> 
> arch/arm/mach-imx/built-in.o: In function `imx7d_init_irq':
> platform-spi_imx.c:(.init.text+0x25a8): undefined reference to `imx_src_init'
> 
> This adds that one as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0be5da9dc249 ("ARM: imx: imx7d requires anatop")

Applied as a non-critical fix for 4.5, thanks.
