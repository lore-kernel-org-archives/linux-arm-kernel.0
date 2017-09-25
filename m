From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 Sep 2017 22:15:12 +0200
Subject: [PATCH] ARM: dts: at91: sama5d2 Xplained: Describe the SD card
 power supply
In-Reply-To: <20170905101805.15127-1-romain.izard.pro@gmail.com>
References: <20170905101805.15127-1-romain.izard.pro@gmail.com>
Message-ID: <20170925201512.2jwuyhsjf6pgjuwi@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2017 at 12:18:05 +0200, Romain Izard wrote:
> As the SAMA5D2 SDHCI controller works with an external power supply,
> describe the power supply for the SD card slot. This makes it possible
> to use mmc power sequences, in the case of external SDIO modules.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
