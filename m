From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 2 May 2012 12:45:06 -0500
Subject: [PATCH 03/15] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <1335958420-5193-4-git-send-email-shawn.guo@linaro.org>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <1335958420-5193-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <ADE657CA350FB648AAC2C43247A983F0020698952162@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 02, 2012 4:33 AM, Shawn Guo wrote:
>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <rmallon@gmail.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-ep93xx/adssphere.c             |    1 +
>  arch/arm/mach-ep93xx/core.c                  |    5 +++++
>  arch/arm/mach-ep93xx/crunch.c                |    4 +---
>  arch/arm/mach-ep93xx/edb93xx.c               |    8 ++++++++
>  arch/arm/mach-ep93xx/gesbc9312.c             |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h |    7 +++++++
>  arch/arm/mach-ep93xx/micro9.c                |    4 ++++
>  arch/arm/mach-ep93xx/simone.c                |    1 +
>  arch/arm/mach-ep93xx/snappercl15.c           |    1 +
>  arch/arm/mach-ep93xx/ts72xx.c                |    1 +
>  arch/arm/mach-ep93xx/vision_ep9307.c         |    1 +
>  11 files changed, 31 insertions(+), 3 deletions(-)

Shawn,

I'm ok with these changes for ep93xx.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

I'm not sure what tree this patch was based on but you will have
some fuzz issues with linux-next due to some other changes to
core.c, snappercl15.c, and ts72xx.c. Just wanted to make sure
you were aware of this.

Regards,
Hartley
