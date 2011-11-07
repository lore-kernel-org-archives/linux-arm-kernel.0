From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 7 Nov 2011 11:10:48 -0600
Subject: [PATCH 09/41] ARM: restart: ep93xx: use new restart hook
In-Reply-To: <E1RN6kG-0001XA-GF@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6kG-0001XA-GF@rmk-PC.arm.linux.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F39DF78498@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, November 06, 2011 10:43 AM, Russell King wrote:
>
> Hook these platforms restart code into the new restart hook rather than
> using arch_reset().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-ep93xx/adssphere.c             |    1 +
>  arch/arm/mach-ep93xx/core.c                  |   12 ++++++++++++
>  arch/arm/mach-ep93xx/edb93xx.c               |    8 ++++++++
>  arch/arm/mach-ep93xx/gesbc9312.c             |    1 +
>  arch/arm/mach-ep93xx/include/mach/platform.h |    2 ++
>  arch/arm/mach-ep93xx/include/mach/system.h   |   11 -----------
>  arch/arm/mach-ep93xx/micro9.c                |    4 ++++
>  arch/arm/mach-ep93xx/simone.c                |    1 +
>  arch/arm/mach-ep93xx/snappercl15.c           |    1 +
>  arch/arm/mach-ep93xx/ts72xx.c                |    1 +
>  arch/arm/mach-ep93xx/vision_ep9307.c         |    1 +
>  11 files changed, 32 insertions(+), 11 deletions(-)

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Thanks!
