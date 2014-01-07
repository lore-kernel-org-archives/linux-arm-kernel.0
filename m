From: horms@verge.net.au (Simon Horman)
Date: Tue, 7 Jan 2014 10:20:15 +0900
Subject: [PATCH 0/3] Add QSPI support on r8a7791/koelsch
In-Reply-To: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20140107012015.GC2196@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 04:34:13PM +0100, Geert Uytterhoeven wrote:
> This series adds support for the Spansion s25fl512s SPI FLASH on the
> r8a7791-based Koelsch board:
> 
>     [1/3] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups

I believe that Laurent should handle patch 1/3.

>     [2/3] ARM: shmobile: r8a7791: add QSPI clock
>     [3/3] ARM: shmobile: Koelsch: Add QSPI support

I believe that patch 3/3 depends on patch 1/3.
So I would like to wait for Laurent to handle patch 1/3.

Also, please post a patch to update the koelsch defconfig.

> This applies to non-multiplatform Koelsch only.  Multi-platform Koelsch
> support will be added when the spi-rspi driver gains DT support.
