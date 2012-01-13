From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 11:52:24 -0600
Subject: [PATCH 10/11] ep93xx: Move EP93XX_SYSCON defines to SoC private
 header
In-Reply-To: <1326251676-7593-11-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-11-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBB13@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2012 8:15 PM, Ryan Mallon wrote:
>
> The EP93XX_SYSCON defines are now no longer needed outside of
> the EP93xx SoC core code, so they can be moved to a private header.
> 
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   90 -----------------------
>  arch/arm/mach-ep93xx/soc.h                      |   90 +++++++++++++++++++++++
>  2 files changed, 90 insertions(+), 90 deletions(-)

Looks good.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
