From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 9 Aug 2016 17:29:05 +0530
Subject: [PATCH v4 0/3] Support for the LCDK
In-Reply-To: <20160805202951.2848-1-kbeldan@baylibre.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <20160805202951.2848-1-kbeldan@baylibre.com>
Message-ID: <57A9C589.3010600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 06 August 2016 01:59 AM, Karl Beldan wrote:
> This depends on "ARM: dts: da850: Add missing pin muxing for the UARTs".
> 
> Changes from v1:
>  - s/omapl138/da850/
>  - Remove earlycon from bootargs
>  - Remove console=ttyS2,115200n8 from bootargs (workaround for preferred console)
>  - Add patches for CONFIG_SMSC_PHY=y and CONFIG_RTC_DRV_OMAP=m
> 
> Changes from v2:
>  - [1] Remove references to C6748: replace 'L138/C6748 Dev Kit (LCDK)' with 'LCDK'
>  - Change license from 'GPLv2 or later' to 'GPLv2'
> 
> Changes from v3:
>  - revert v2 [1]

Series applied and boot tested on my LCDK.

For future, when posting a new version, please send as an independent
series and not reply to the very first posting.

Thanks,
Sekhar
