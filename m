From: broonie@kernel.org (Mark Brown)
Date: Mon, 16 Dec 2013 17:16:45 +0000
Subject: [GIT PULL 6/7] Samsung DT for v3.14
In-Reply-To: <52AE0F9A.3010407@samsung.com>
References: <52AE0F9A.3010407@samsung.com>
Message-ID: <20131216171645.GJ3185@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 05:22:50AM +0900, Kukjin Kim wrote:

> Samsung DT updates for v3.14
> - Add support Octa Cores for exynos5420
>   : populate CPU node entries to 8 Cores
>   : extend mct to support 8 local interrupts
> - Update dwmmc nodes for exynos5250 and exynos5420
>   : change status property of dwmmc nodes for exynos5250
>   : move dwmmc nodes from exynos5 to exynos5250 because
>     it's different between exynos5250 and exynos5420
>   : rename mmc nodes from dwmmc for exynos5 SoCs
>   : add dwmmc nodes for exynos5420
> - Add G-Scaler nodes for exynos5420
> - Add HS-i2c nodes in exynos5420
>   : High Speed I2C 7 channels (4 to 10)
> - Update sysreg binding and node name in exynos4
> - Update min voltage on exynos5250-arndale
> - Move fifo-depth property from boards to exynos5250 SoC
>   : because the fifo-depth property is SoC specific

I've been sending updates to disable the I2C and SPI devices by default
on 5250 for some time now - is there any chance of getting them
included?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131216/a28457b6/attachment.sig>
