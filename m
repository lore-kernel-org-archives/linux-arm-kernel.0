From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 9 May 2012 13:47:09 +0530
Subject: [PATCH 00/10] spi: s3c64xx: add support for device tree
In-Reply-To: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CABb+yY00+Et7sXgb0s6GinOdKu6PeQsWD9A_SoV2M3VKMejz7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 3:34 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> This patch series adds device tree based discovery support for Samsung's
> s3c64xx compatible spi controller. This is mainly tested for Exynos4210
> and Exynos5250 with onboard spi nor flash device.
>
> This patch series is based on Linux 3.4-rc5 with the following two
> patch series applied.
>
> [1] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg10494.html
> ? ?[PATCH 00/20] ARM: Samsung: Add support for Exynos5250 Rev1.0
>
> [2] http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg09640.html
> ? ?[PATCH 0/6] S3C24XX: Add support for HSSPI on S3C2416/S3C2443
>
> Thomas Abraham (10):
> ?spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ macro
> ?spi: s3c64xx: move controller information into driver data
> ?ARM: Samsung: Remove spi hardware controller information from platform data
> ?ARM: Samsung: Remove pdev pointer paremeter from spi gpio setup functions
> ?ARM: Samsung: Update the device names for spi clock lookup
> ?ARM: Samsung: Modify s3c64xx_spi{0|1|2}_set_platdata function
> ?spi: s3c64xx: Remove the 'set_level' callback from controller data
> ?ARM: Exynos4: Fix the incorrect hierarchy of spi controller bus clock
> ?ARM: Exynos5: Add spi clock support
> ?spi: s3c64xx: add device tree support
>
Look ok to me.  FWIW,  Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
