From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jul 2014 11:08:11 +0200
Subject: [PATCH v3 0/8] ARM: rockchip: add initial support for rk3288
In-Reply-To: <1406324980-2450-1-git-send-email-heiko@sntech.de>
References: <1406324980-2450-1-git-send-email-heiko@sntech.de>
Message-ID: <4952360.Q1n75UemR2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 July 2014 23:49:32 Heiko Stuebner wrote:
> This series adds the initial support for Rockchip rk3288 socs including
> debug uart and devicetree files for the rk3288 evaluation board and
> enables these boards to boot into an initramfs.
> 
> Boards using uboot need an updated bootloader, which must start the timer
> supplying the architected timer, while the coreboot bootloader already does
> this. It also depends on the patch
>     "irqchip: gic: Add binding probe for ARM GIC400"
> which should have made it into the irqchip tree today.

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
