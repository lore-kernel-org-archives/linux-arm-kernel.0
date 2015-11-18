From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 10:31:20 +0100
Subject: [PATCHv2 3/3] ASoC: samsung: pass filter function as pointer
In-Reply-To: <564BDEBE.2080706@samsung.com>
References: <6346833.MfUC71I3uD@wuerfel> <6346833.dgFksO4fT8@wuerfel>
 <564BDEBE.2080706@samsung.com>
Message-ID: <4007784.QRStAbUhLz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 11:13:18 Krzysztof Kozlowski wrote:
> 
> I also tested entire patchset on Exynos4412/Trats2 board (custom kernel
> with audio working) for regressions and it worked fine. However, since
> this was not a S3C24xx/S3C64xx board, I don't find that testing
> sufficient for a tag. So only:
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 

Thanks!

Mark, can you take the three patches through the ASoC tree?

	Arnd
