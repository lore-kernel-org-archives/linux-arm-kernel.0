From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 18 Aug 2016 08:58:22 +0200
Subject: [PATCH] MAINTAINERS: add myself as Samsung SPI maintainer
In-Reply-To: <20160818064431.8982-1-andi.shyti@samsung.com>
References: <20160818064431.8982-1-andi.shyti@samsung.com>
Message-ID: <CAJKOXPe-=qLNSsm9AQHkcVYGSV=yMjsawMbBRbeo6h7sQuzHsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 8:44 AM, Andi Shyti <andi.shyti@samsung.com> wrote:
> Create a new entry for the Samsung SPI driver supported by the
> drivers/spi/spi-s3c* and remove it from its original place under
> "ARM/SAMSUNG EXYNOS ARM ARCHITECTURES".
>
> The original maintainership inherited from the Samsung Exynos
> ARM Architecture is kept as it was (i.e. Kukjin and Krzysztof), I
> will help and co-maintain the driver.
>
> CC: Krzysztof Kozlowski <krzk@kernel.org>
> CC: Kukjin Kim <kgene@kernel.org>
> CC: Mark Brown <broonie@kernel.org>
> CC: linux-samsung-soc at vger.kernel.org
> CC: linux-spi at vger.kernel.org
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
> Hi,
>
> this patch depends on Krzysztof's previous patch-set on the
> MAINTAINER file: https://lkml.org/lkml/2016/8/16/571

Thanks for taking care of SPI. From my side:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

I think there is no strict dependency on my patch (patches do not
overlap) so it can safely go through SPI tree if accepted.

Best regards,
Krzysztof
