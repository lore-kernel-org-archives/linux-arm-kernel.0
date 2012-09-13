From: stefan@sostec.de (stefan at sostec.de)
Date: Thu, 13 Sep 2012 10:46:26 +0200 (CEST)
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
In-Reply-To: <1347368390-31252-7-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <170e340b60e06a37978762833c27fa02.squirrel@sirius.lasnet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
>
> This moves such data out of the pxa include directories
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

>  arch/arm/mach-pxa/ezx.c                                |    8 ++++----

Acked-By: Stefan Schmidt <stefan@openezx.org>

regards
Stefan Schmidt
