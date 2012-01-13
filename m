From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 11:25:19 -0600
Subject: [PATCH 03/11] ep93xx: Move peripheral defines to local SoC header
In-Reply-To: <1326251676-7593-4-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-4-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBAF6@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2012 8:14 PM, Ryan Mallon wrote:
>
> Move the AHB/APB peripheral defines to local SoC header since they
> are only needed by the core SoC code. The UART defines are not
>  moved because they are used by the mach/uncompress.h header.
>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/core.c                     |    1 +
>  arch/arm/mach-ep93xx/dma.c                      |    2 +
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   57 +----------------------
>  arch/arm/mach-ep93xx/soc.h                      |   54 +++++++++++++++++++++
>  4 files changed, 58 insertions(+), 56 deletions(-)

Looks good.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
