From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 3 Feb 2018 11:57:31 +0100 (CET)
Subject: [PATCH] staging: vc04_services: remove unused files
In-Reply-To: <1517517543-34957-1-git-send-email-clabbe@baylibre.com>
References: <1517517543-34957-1-git-send-email-clabbe@baylibre.com>
Message-ID: <131618745.47691.1517655451980@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Corentin Labbe <clabbe@baylibre.com> hat am 1. Februar 2018 um 21:39 geschrieben:
> 
> 
> All thoses files are not used by anybody.
> Lets just remove them.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../interface/vchiq_arm/vchiq_build_info.h         | 37 --------------
>  .../interface/vchiq_arm/vchiq_memdrv.h             | 59 ----------------------
>  .../interface/vchiq_arm/vchiq_version.c            | 59 ----------------------
>  3 files changed, 155 deletions(-)
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_build_info.h
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_memdrv.h
>  delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_version.c
> 

The memdrv interface is possibly used by a driver in the RPi Foundation tree, but i don't see any need to upstream it.

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
