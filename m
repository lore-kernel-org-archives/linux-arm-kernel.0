From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 4 Feb 2010 20:34:26 +0200
Subject: [PATCH] Add USB support for i.MX27/35 and Phytec i.MX boards
In-Reply-To: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
References: <1265295825-8705-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100204183426.GA30488@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Feb 04, 2010 at 04:03:37PM +0100, Sascha Hauer wrote:

[snip]

>  arch/arm/mach-mx2/Kconfig                 |    2 +
>  arch/arm/mach-mx2/mach-pca100.c           |  103 ++++
>  arch/arm/mach-mx2/mach-pcm038.c           |   22 +
>  arch/arm/mach-mx3/Kconfig                 |    2 +
>  arch/arm/mach-mx3/mach-pcm037.c           |  137 ++++--
>  arch/arm/mach-mx3/mach-pcm043.c           |   53 ++
>  arch/arm/mach-mx3/pcm037.c                |  795 +++++++++++++++++++++++++++++
>  arch/arm/mach-mx3/pcm043.c                |  367 +++++++++++++
>  arch/arm/plat-mxc/ehci.c                  |  118 ++++-
>  arch/arm/plat-mxc/include/mach/mxc_ehci.h |    4 +
>  drivers/usb/gadget/fsl_mx3_udc.c          |   31 +-
>  11 files changed, 1570 insertions(+), 64 deletions(-)
>  create mode 100644 arch/arm/mach-mx3/pcm037.c
>  create mode 100644 arch/arm/mach-mx3/pcm043.c

Is the addition of these two files intended?

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
