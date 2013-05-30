From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 May 2013 10:42:41 +0800
Subject: [RFC 2/3] SPI: imx: Using SPI-master "cs_gpios" field for array
 of chipselects instead of private
In-Reply-To: <1369847430-10799-2-git-send-email-shc_work@mail.ru>
References: <20130529144909.GT3660@sirena.org.uk>
 <1369847430-10799-1-git-send-email-shc_work@mail.ru>
 <1369847430-10799-2-git-send-email-shc_work@mail.ru>
Message-ID: <20130530024240.GC1875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 09:10:29PM +0400, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/spi/spi-imx.c | 49 +++++++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 22 deletions(-)
