From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 1 Jul 2014 09:25:59 +0300
Subject: [PATCH 06/17] video: fbdev: s3c-fb: remove s5p64x0 related fimd
 codes
In-Reply-To: <1404163947-3105-7-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <53B25477.4020902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/07/14 00:32, Kukjin Kim wrote:
> This patch removes fimd codes for s5p6440 and s5p6450 SoCs.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../devicetree/bindings/video/samsung-fimd.txt     |    1 -
>  drivers/video/fbdev/Kconfig                        |    2 +-
>  drivers/video/fbdev/s3c-fb.c                       |   30 --------------------
>  3 files changed, 1 insertion(+), 32 deletions(-)

Shall I queue this and patch 15/17 via fbdev tree, or are there
dependencies and the whole series should go as one?

If the latter, for this and 15/17:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140701/4977e75e/attachment.sig>
