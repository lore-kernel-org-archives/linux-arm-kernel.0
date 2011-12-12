From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 Dec 2011 13:24:47 +0200
Subject: [PATCH 08/10] omapfb: lcd_ams_delta: Drive control lines over GPIO
In-Reply-To: <1323634328-856-9-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
 <1323634328-856-9-git-send-email-jkrzyszt@tis.icnet.pl>
Message-ID: <1323689087.3852.19.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-12-11 at 21:12 +0100, Janusz Krzysztofik wrote:
> Don't use Amstrad Delta custom I/O functions any longer, use GPIO API
> instead.
> 
> Depends on patch 5/10 "MTD: NAND: ams-delta: Use GPIO instead of custom
> I/O".
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c             |   10 -------
>  arch/arm/plat-omap/include/plat/board-ams-delta.h |    2 -
>  drivers/video/omap/lcd_ams_delta.c                |   27 +++++++++++++++-----
>  3 files changed, 20 insertions(+), 19 deletions(-)

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111212/07fd6874/attachment.sig>
