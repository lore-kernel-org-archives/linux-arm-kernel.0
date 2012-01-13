From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 11:22:36 -0600
Subject: [PATCH 02/11] ep93xx: Move GPIO defines to gpio-ep93xx.h
In-Reply-To: <1326251676-7593-3-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-3-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBAEF@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2012 8:14 PM, Ryan Mallon wrote:
>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    8 --------
>  arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |   10 ++++++++++
>  2 files changed, 10 insertions(+), 8 deletions(-)

Nitpick... You should add a commit comment.

Other than that, looks good.

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
