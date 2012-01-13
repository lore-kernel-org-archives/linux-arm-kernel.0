From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 13 Jan 2012 11:28:40 -0600
Subject: [PATCH 05/11] ep93xx: Move arch_reset to core.c
In-Reply-To: <1326251676-7593-6-git-send-email-rmallon@gmail.com>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-6-git-send-email-rmallon@gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3F99EBAFB@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 10, 2012 8:15 PM, Ryan Mallon wrote:
> 
> Move the arch_reset function from include/mach/system.h to core.c.
> This removes the need for the EP93XX_SYSCON_DEVCFG defines to
>  be exported in the include/mach headers.
>
> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Mika Westerberg <mika.westerberg@iki.fi>
> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
> ---
>  arch/arm/mach-ep93xx/core.c                |   18 ++++++++++++++++++
>  arch/arm/mach-ep93xx/include/mach/system.h |   14 +-------------
>  2 files changed, 19 insertions(+), 13 deletions(-)

As you already found, the ARM reset rework already handled this.

Regards,
Hartley
