From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 21:08:26 +0800
Subject: [PATCH 04/17] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F002069887EDE9@AUSP01VMBX24.collaborationhost.net>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-5-git-send-email-shawn.guo@linaro.org>
 <ADE657CA350FB648AAC2C43247A983F002069887EDE9@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20120427130823.GB2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 05:42:16PM -0500, H Hartley Sweeten wrote:
> On Thursday, April 26, 2012 8:39 AM, Shawn Guo wrote:
> >
> > Cc: Hartley Sweeten <hsweeten@visionengravers.com>
> > Cc: Ryan Mallon <rmallon@gmail.com>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  arch/arm/mach-ep93xx/adssphere.c             |    1 +
> >  arch/arm/mach-ep93xx/core.c                  |    5 +++++
> >  arch/arm/mach-ep93xx/crunch.c                |    4 +---
> >  arch/arm/mach-ep93xx/gesbc9312.c             |    1 +
> >  arch/arm/mach-ep93xx/include/mach/platform.h |    7 +++++++
> >  arch/arm/mach-ep93xx/micro9.c                |    4 ++++
> >  arch/arm/mach-ep93xx/simone.c                |    1 +
> >  arch/arm/mach-ep93xx/snappercl15.c           |    1 +
> >  arch/arm/mach-ep93xx/ts72xx.c                |    1 +
> >  arch/arm/mach-ep93xx/vision_ep9307.c         |    1 +
> >  10 files changed, 23 insertions(+), 3 deletions(-)
> 
> The machines defined in arch/arm/mach-ep93xx/edb93xx.c are missing
> the .init_late addition.
> 
How did I get it missed?  Thanks for the catching, Hartley.

-- 
Regards,
Shawn
