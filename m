From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Thu, 18 Nov 2010 11:07:34 +0200
Subject: [PATCH] OMAP: DSS2: Add back authors of panel-generic.c based
	drivers
In-Reply-To: <1290044759-2903-1-git-send-email-bryan.wu@canonical.com>
References: <1290044759-2903-1-git-send-email-bryan.wu@canonical.com>
Message-ID: <1290071254.3431.0.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-11-18 at 09:45 +0800, ext Bryan Wu wrote:
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
> ---
>  drivers/video/omap2/displays/panel-generic-dpi.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
> index 6702cf6..07eb30e 100644
> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
> @@ -4,6 +4,16 @@
>   * Copyright (C) 2010 Canonical Ltd.
>   * Author: Bryan Wu <bryan.wu@canonical.com>
>   *
> + * LCD panel driver for Sharp LQ043T1DG01
> + *
> + * Copyright (C) 2009 Texas Instruments Inc
> + * Author: Vaibhav Hiremath <hvaibhav@ti.com>
> + *
> + * LCD panel driver for Toppoly TDO35S
> + *
> + * Copyright (C) 2009 CompuLab, Ltd.
> + * Author: Mike Rapoport <mike@compulab.co.il>
> + *
>   * Copyright (C) 2008 Nokia Corporation
>   * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>   *

Thanks, applied.

 Tomi
