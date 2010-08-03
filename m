From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 03 Aug 2010 14:41:28 +0300
Subject: [PATCH 0/3 v2] Enable pxa310 usb otg port host mode
In-Reply-To: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
References: <1280232420-28691-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <4C580068.6080108@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping!

On 07/27/10 15:06, Igor Grinberg wrote:
> This patch series introduces the U2D Controller and
> U2D ULPI Host driver for PXA310 and enables cm-x300 usb host port2.
>
> This patch series depends on
> "Generic ULPI driver extention" patch series,
> which have been reviewed at linux-usb mailing list
>
> Igor Grinberg (3):
>   [ARM] pxa3xx: Add U2D controller and ULPI driver
>   [ARM] usb/host/ohci-pxa27x: enable OHCI over U2DC
>   [ARM] pxa/cm-x300: enable USB host port2
>
>  arch/arm/mach-pxa/Kconfig                   |    4 +
>  arch/arm/mach-pxa/Makefile                  |    2 +-
>  arch/arm/mach-pxa/cm-x300.c                 |   77 ++++++
>  arch/arm/mach-pxa/devices.c                 |   28 ++
>  arch/arm/mach-pxa/devices.h                 |    1 +
>  arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h |   35 +++
>  arch/arm/mach-pxa/pxa3xx-ulpi.c             |  392 +++++++++++++++++++++++++++
>  arch/arm/mach-pxa/pxa3xx.c                  |    2 +-
>  drivers/usb/host/ohci-pxa27x.c              |    7 +
>  9 files changed, 546 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h
>  create mode 100644 arch/arm/mach-pxa/pxa3xx-ulpi.c
>
>
>   

-- 
Regards,
Igor.
