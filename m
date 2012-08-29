From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 29 Aug 2012 18:06:05 +0300
Subject: [PATCH 7/9] ARM: OMAP1: move lcd pdata out of arch/arm/*
In-Reply-To: <1346195937-6383-8-git-send-email-grinberg@compulab.co.il>
References: <1346195937-6383-1-git-send-email-grinberg@compulab.co.il>
 <1346195937-6383-8-git-send-email-grinberg@compulab.co.il>
Message-ID: <1346252765.12380.1.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-08-29 at 02:18 +0300, Igor Grinberg wrote:
> omap1 lcd platform data resides inside plat/board.h while it
> should be inside include/linux/...
> Move the omap1 lcd platform data to include/linux/omapfb.h.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c   |    1 -
>  arch/arm/mach-omap1/board-fsample.c     |    1 -
>  arch/arm/mach-omap1/board-htcherald.c   |    1 -
>  arch/arm/mach-omap1/board-nokia770.c    |    1 -
>  arch/arm/mach-omap1/board-palmte.c      |    1 -
>  arch/arm/mach-omap1/board-palmtt.c      |    1 -
>  arch/arm/mach-omap1/board-palmz71.c     |    1 -
>  arch/arm/mach-omap1/board-perseus2.c    |    1 -
>  arch/arm/mach-omap1/board-sx1.c         |    1 -
>  arch/arm/plat-omap/fb.c                 |    2 --
>  arch/arm/plat-omap/include/plat/board.h |    7 -------
>  include/linux/omapfb.h                  |    7 ++++++-
>  12 files changed, 6 insertions(+), 19 deletions(-)
> 

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120829/9e75c995/attachment-0001.sig>
