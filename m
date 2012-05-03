From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 May 2012 23:05:02 +0800
Subject: [PATCH 03/15] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0020698952162@AUSP01VMBX24.collaborationhost.net>
References: <1335958420-5193-1-git-send-email-shawn.guo@linaro.org>
 <1335958420-5193-4-git-send-email-shawn.guo@linaro.org>
 <ADE657CA350FB648AAC2C43247A983F0020698952162@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120503150459.GI2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 12:45:06PM -0500, H Hartley Sweeten wrote:
> Shawn,
> 
> I'm ok with these changes for ep93xx.
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
Thanks, Hartley.

> I'm not sure what tree this patch was based on but you will have
> some fuzz issues with linux-next due to some other changes to
> core.c, snappercl15.c, and ts72xx.c. Just wanted to make sure
> you were aware of this.
> 
Noted.  I will send the series to arm-soc and hopefully Arnd and Olof
will have it sorted out there.

-- 
Regards,
Shawn
