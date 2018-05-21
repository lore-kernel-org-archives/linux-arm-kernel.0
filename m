From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 May 2018 10:12:09 +0200
Subject: [PATCH 0/2] get rid of Kconfig symbol MACH_MESON8B
In-Reply-To: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
References: <20180520172353.19256-1-martin.blumenstingl@googlemail.com>
Message-ID: <1526890329.2822.0.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-05-20 at 19:23 +0200, Martin Blumenstingl wrote:
> as noted by Kevin [0] there are two Kconfig symbols which only differ
> in their Kconfig help text and the list of .dtbs that are being built.
> the goal of this small series is to get rid of the unnecessary
> MACH_MESON8B Kconfig symbol by merging it into MACH_MESON8.
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-amlogic/2018-May/007342.html
> 
> Martin Blumenstingl (2):
>   ARM: dts: meson: build the Meson8b .dtbs with MACH_MESON8
>   ARM: meson: merge Kconfig symbol MACH_MESON8B into MACH_MESON8
> 
>  arch/arm/boot/dts/Makefile  | 5 ++---
>  arch/arm/mach-meson/Kconfig | 9 +--------
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 

For the series:

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
