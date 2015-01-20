From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 20 Jan 2015 21:18:30 +0800
Subject: [PATCH 2/8] soc: Add MediaTek pericfg controller support
In-Reply-To: <1421747231-554-3-git-send-email-s.hauer@pengutronix.de>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1421759910.11671.69.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-20 at 10:47 +0100, Sascha Hauer wrote:
<...>
> diff --git a/drivers/soc/mediatek/mtk-pericfg.c b/drivers/soc/mediatek/mtk-pericfg.c
> index b7ee902..aa9a7eb 100644
> --- a/drivers/soc/mediatek/mtk-pericfg.c
> +++ b/drivers/soc/mediatek/mtk-pericfg.c
> @@ -1,6 +1,5 @@
>  /*
>   * Copyright (c) 2014 MediaTek Inc.
> - * Author: Flora Fu <flora.fu@mediatek.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as

Hi Sascha,

I believe you want to add mtk-pericfg.c here instead of adding it in
first patch and only change author here.

Joe.C
