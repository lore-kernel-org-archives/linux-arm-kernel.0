From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 16 Feb 2010 17:14:20 +0200
Subject: [PATCH 0/3] mx25: framebuffer support
In-Reply-To: <cover.1265786237.git.baruch@tkos.co.il>
References: <cover.1265786237.git.baruch@tkos.co.il>
Message-ID: <20100216151420.GD32332@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping?

I'd really like to see this merged in .34.

Thanks,
baruch

On Wed, Feb 10, 2010 at 09:25:17AM +0200, Baruch Siach wrote:
> This set of patches adds support for the i.MX25 LCD controller block using the 
> imxfb driver. Platform code for the i.MX25 PDK board is also added.
> 
> Tested on the i.MX25 PDK.
> 
> Baruch Siach (3):
>   imxfb: add support for i.MX25
>   mx25: add platform support for imxfb
>   mx25pdk: add LCD support
> 
>  arch/arm/mach-mx25/clock.c                  |   12 ++++++
>  arch/arm/mach-mx25/devices.c                |   23 +++++++++++
>  arch/arm/mach-mx25/devices.h                |    1 +
>  arch/arm/mach-mx25/mx25pdk.c                |   55 +++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +
>  arch/arm/plat-mxc/include/mach/mx25.h       |    2 +
>  drivers/video/Kconfig                       |    2 +-
>  7 files changed, 96 insertions(+), 1 deletions(-)

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
