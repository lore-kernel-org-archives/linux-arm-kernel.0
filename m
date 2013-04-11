From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 11 Apr 2013 14:51:55 +0300
Subject: [PATCH 12/30] video/exynos: remove unnecessary header inclusions
In-Reply-To: <1365638712-1028578-13-git-send-email-arnd@arndb.de>
References: <1365638712-1028578-1-git-send-email-arnd@arndb.de>
 <1365638712-1028578-13-git-send-email-arnd@arndb.de>
Message-ID: <5166A3DB.6060700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2013-04-11 03:04, Arnd Bergmann wrote:
> In multiplatform configurations, we cannot include headers
> provided by only the exynos platform. Fortunately a number
> of drivers that include those headers do not actually need
> them, so we can just remove the inclusions.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-fbdev at vger.kernel.org
> Cc: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/video/exynos/exynos_mipi_dsi.c          | 2 --
>  drivers/video/exynos/exynos_mipi_dsi_common.c   | 2 --
>  drivers/video/exynos/exynos_mipi_dsi_lowlevel.c | 2 --
>  3 files changed, 6 deletions(-)

I've applied this and the next patch ([PATCH 13/30] video/s3c: move
platform_data out of arch/arm) to fbdev.

I also fixed the extra space mentioned by Jingoo.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130411/62aa70ae/attachment.sig>
