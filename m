From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Oct 2016 13:15:13 +0200
Subject: [PATCH v2 0/2] ARM: oxnas: Add SMP support for OX820
In-Reply-To: <20161021085848.1754-1-narmstrong@baylibre.com>
References: <20161021085848.1754-1-narmstrong@baylibre.com>
Message-ID: <3451192.la7YkVR9rV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 21, 2016 10:58:46 AM CEST Neil Armstrong wrote:
> In order to support the SMP feature of the Oxford Semiconductor OX820 SoC,
> add the necessary code to handle the wake-up, hotplug and cpu entry.
> 
> The OX820 has an ARM11MPCORE cluster with 2 cores and has proper hardware
> support for secondary core booting.
> 
> Changes since v1 at http://lkml.kernel.org/r/20161017084303.20078-1-narmstrong at baylibre.com
>  - Remove useless holding pen loops and spinlock in boot_secondary
> 

Thanks for the update, much nicer!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
