From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 15:46:33 +0800
Subject: [PATCH 0/2] simple device tree support for mxsfb
In-Reply-To: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
References: <1340701379-8619-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120703074631.GE22705@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On Tue, Jun 26, 2012 at 05:02:57PM +0800, Shawn Guo wrote:
> It adds a simple device tree support for mxsfb driver.
> 
> Shawn Guo (2):
>   video: mxsfb: move mxsfb.h into include/linux
>   video: mxsfb: add simple device tree probe
> 
I just queued these two patches on mxs arch tree.  Please let me know
if you see problem with that.

Regards,
Shawn

>  Documentation/devicetree/bindings/fb/mxsfb.txt     |   21 +++++++
>  arch/arm/mach-mxs/devices-mx23.h                   |    2 +-
>  arch/arm/mach-mxs/devices-mx28.h                   |    2 +-
>  arch/arm/mach-mxs/devices/platform-mxsfb.c         |    2 +-
>  drivers/video/mxsfb.c                              |   62 +++++++++++++++-----
>  .../include/mach => include/linux}/mxsfb.h         |    6 +-
>  6 files changed, 75 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/fb/mxsfb.txt
>  rename {arch/arm/mach-mxs/include/mach => include/linux}/mxsfb.h (95%)
> 
> -- 
> 1.7.5.4
> 
> 
