From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 2 Dec 2012 13:25:51 +0000
Subject: [PATCH 2/2] ARM: ixp4xx: Using gpiolib rather than a private GPIO
 API
In-Reply-To: <1354435770-2719-2-git-send-email-shc_work@mail.ru>
References: <201212020011.42105.arnd@arndb.de>
 <1354435770-2719-1-git-send-email-shc_work@mail.ru>
 <1354435770-2719-2-git-send-email-shc_work@mail.ru>
Message-ID: <201212021325.52058.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 December 2012, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-ixp4xx/common.c                |   29 ++++++++++-----
>  arch/arm/mach-ixp4xx/dsmg600-setup.c         |    9 ++---
>  arch/arm/mach-ixp4xx/goramo_mlr.c            |   31 ++++++++--------
>  arch/arm/mach-ixp4xx/include/mach/platform.h |   38 --------------------
>  arch/arm/mach-ixp4xx/ixdp425-setup.c         |    6 ++--
>  arch/arm/mach-ixp4xx/nas100d-setup.c         |    9 ++---
>  arch/arm/mach-ixp4xx/nslu2-setup.c           |    5 +--
>  drivers/input/misc/ixp4xx-beeper.c           |   49 ++++++++++++++------------
>  drivers/ptp/ptp_ixp46x.c                     |   31 +++++++++++-----
>  9 files changed, 91 insertions(+), 116 deletions(-)

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
