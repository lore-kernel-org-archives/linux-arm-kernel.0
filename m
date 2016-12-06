From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 5 Dec 2016 17:50:13 -0800
Subject: [RESEND PATCH v2 4/7] drm/vc4: Add support for the VEC (Video
 Encoder) IP
In-Reply-To: <1480686493-4813-5-git-send-email-boris.brezillon@free-electrons.com>
References: <1480686493-4813-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480686493-4813-5-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <c1b904db-be3d-1e83-37bc-1f750ecfe224@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2016 05:48 AM, Boris Brezillon wrote:
> The VEC IP is a TV DAC, providing support for PAL and NTSC standards.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---

> diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
> new file mode 100644
> index 000000000000..2d4256fcc6f2
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/vc4_vec.c
> @@ -0,0 +1,657 @@
> +/*
> + * Copyright (C) 2016 Broadcom Limited

The standard copyright template post acquisition is just Broadcom, not
Broadcom Limited, nor Broadcom corporation. Can you audit your entire
submission and fix this up accordingly?

Thanks!
-- 
Florian
