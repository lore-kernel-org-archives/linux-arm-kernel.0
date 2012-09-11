From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 11 Sep 2012 16:56:44 +0300
Subject: [PATCH 07/16] ARM: pxa: move platform_data definitions
In-Reply-To: <1347368390-31252-7-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-7-git-send-email-arnd@arndb.de>
Message-ID: <504F431C.4080303@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/12 15:59, Arnd Bergmann wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the pxa include directories
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

>  arch/arm/mach-pxa/cm-x270.c                            |    4 ++--
>  arch/arm/mach-pxa/cm-x2xx.c                            |    2 +-
>  arch/arm/mach-pxa/cm-x300.c                            |   10 +++++-----
>  arch/arm/mach-pxa/em-x270.c                            |   10 +++++-----
>  arch/arm/mach-pxa/pxa3xx-ulpi.c                        |    2 +-
>  .../linux/platform_data/usb-pxa3xx-ulpi.h              |    0
>  rename arch/arm/mach-pxa/include/mach/pxa3xx-u2d.h => include/linux/platform_data/usb-pxa3xx-ulpi.h (100%)

Acked-by: Igor Grinberg <grinberg@compulab.co.il>

-- 
Regards,
Igor.
