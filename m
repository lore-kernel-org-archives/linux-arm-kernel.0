From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 28 Feb 2018 16:43:18 +0100
Subject: [PATCH 1/3] MAINTAINERS: ARM: at91: update entry for ARM/Microchip
In-Reply-To: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
References: <c00e7bf21945e844c6154b374924b7ff520d1316.1519829594.git.nicolas.ferre@microchip.com>
Message-ID: <20180228154318.GN1479@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/2018 at 15:56:41 +0100, Nicolas Ferre wrote:
> Change the entry name and move it to its alphabetical location.
> We move to ARM/Microchip instead of ARM/ATMEL to reflect the merger
> that is now nearly 2 years old.
> AT91 is kept as the identity of our community. The atmel pattern is
> obviously kept as well. I removed the names of the different SoCs as
> they are better exposed in the arch/arm/mach-at91/Kconfig entries.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
> Hi,
> 
> This patch goes on top of linux-next because Alexandre's email change is taken
> into account (already in arm-soc).
> 

All applied in my at91-soc branch which takes care of the dependency

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
