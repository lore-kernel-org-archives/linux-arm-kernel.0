From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Oct 2014 22:15:51 +0200
Subject: [PATCHv2 0/3] Remove mach/atmel-mci.h
In-Reply-To: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1413534398-22645-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <2020417.En5p6XBEWH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 October 2014 10:26:35 Alexandre Belloni wrote:
> This patch series removes the uses of mach/atmel-mci.h and the files themselves.
> The final goal is to be able to switch AT91 to multiplatform.
> 
> The first patch introduces a new platform_data file and uses it in the driver.
> The two following patches remove the uses of mach/atmel-mci.h and the header
> itself from avR32 and ARM/at91.
> 
> Changes in v2:
>  - include back linux/atmel-mci.h and really remove mach/atmel-mci.h in at91sam9g45_devices.c
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
