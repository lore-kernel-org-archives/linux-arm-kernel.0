From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 21 Jul 2010 17:47:54 +0300
Subject: [PATCH 0/3] Generic ULPI driver extention
In-Reply-To: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
References: <1279198816-30367-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <4C47089A.6020502@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg, Daniel, Sascha,

Any comments?

> This patch series add support for SMSC USB3319 ulpi phy,
> introduces the ulpi specific flags for control over the
> ulpi phy and extends the generic ulpi driver with
> support for Function and Interface control of upli phy.
>
> Depends on:
> From: Ajay Kumar Gupta <ajay.gupta@ti.com>
> Date: Thu,  8 Jul 2010 14:03:01 +0530
> Subject: USB: ulpi: fix compilation warning
>
> From: Eric B?nard <eric@eukrea.com>
> Date: Thu, 15 Jul 2010 09:20:19 +0200
> Subject: [PATCH v2] otg/ulpi.c : fix register write
>
> Igor Grinberg (3):
>   usb/otg/ulpi: remove unused macro
>   usb/otg/ulpi: add support for SMSC USB3319 ulpi phy
>   usb/otg/ulpi: extend the generic ulpi driver.
>
>  arch/arm/mach-mx2/mach-pca100.c          |    4 +-
>  arch/arm/mach-mx3/mach-armadillo5x0.c    |    4 +-
>  arch/arm/mach-mx3/mach-mx31lilly.c       |    4 +-
>  arch/arm/mach-mx3/mach-mx31lite.c        |    2 +-
>  arch/arm/mach-mx3/mach-mx31moboard.c     |    2 +-
>  arch/arm/mach-mx3/mach-pcm037.c          |    4 +-
>  arch/arm/mach-mx3/mach-pcm043.c          |    2 +-
>  arch/arm/mach-mx3/mx31moboard-smartbot.c |    2 +-
>  drivers/usb/otg/Kconfig                  |    2 -
>  drivers/usb/otg/ulpi.c                   |  130 +++++++++++++++++++++++++++---
>  include/linux/usb/otg.h                  |    7 --
>  include/linux/usb/ulpi.h                 |   39 +++++++++
>  12 files changed, 169 insertions(+), 33 deletions(-)
>
>
>   

-- 
Regards,
Igor.
