From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 9 Oct 2013 11:32:51 +0300
Subject: [PATCH V5 4/5] video: exynos_mipi_dsim: Use the generic PHY driver
In-Reply-To: <1380396467-29278-5-git-send-email-s.nawrocki@samsung.com>
References: <1380396467-29278-1-git-send-email-s.nawrocki@samsung.com>
 <1380396467-29278-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <525514B3.5020101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/13 22:27, Sylwester Nawrocki wrote:
> Use the generic PHY API instead of the platform callback
> for the MIPI DSIM DPHY enable/reset control.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Donghwa Lee <dh09.lee@samsung.com>
> ---
> Changes since v4:
>  - PHY label removed from the platform data structure.
> ---
>  drivers/video/exynos/Kconfig           |    1 +
>  drivers/video/exynos/exynos_mipi_dsi.c |   19 ++++++++++---------
>  include/video/exynos_mipi_dsim.h       |    5 ++---
>  3 files changed, 13 insertions(+), 12 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131009/6424ec6a/attachment.sig>
