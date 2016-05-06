From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 6 May 2016 17:07:21 -0400
Subject: [PATCH 1/2] ARM: dts: igep00x0: Add SD card-detect.
In-Reply-To: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
References: <1462568554-7868-1-git-send-email-enric.balletbo@collabora.com>
Message-ID: <CABxcv=nZ1hjVGnNG65eKDrxAYFBcavML+GjxXtfTcVO5N83xkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Enric,

On Fri, May 6, 2016 at 5:02 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Fix SD card remove/insert detection by adding the correct card-detect
> pin. All IGEP OMAP3 based boards use the same card-detect pin.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

Shouldn't his be Suggested-by: Ladislav Michl <ladis@linux-mips.org> instead?

Or if the patch was originally from Ladis, then he should remain the
author with your S-o-B after his.

Patch looks good to me though.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
