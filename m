From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 1 Jul 2010 18:49:24 +0900
Subject: [PATCH 0/8] ARM: S5PV310: Add support for Samsung S5PV310 SoC
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTilZ0ZnFp6grlwHe9r8mWZ0G6bMkV8LJasVd0yjy@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

How about to start the single kernel preparation from this patch?
Instead of create the new machine directory, we just put the
mach-s5pv210 or create the new one.

and don't you think it's confusing of names.
s5pc110 (same as s5pv210), vs. s5pc210 (same as s5pv310).
maybe someone don't read the chip carefully. it's misleading the chips.

Thank you,
Kyungmin Park

On Fri, Jun 25, 2010 at 11:27 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> This patch set adds support for Samsung S5PV310/S5PC210. The S5PV310
> integrates a ARM Cortex A9 microprocessor with several other peripherals
> to support features such as multimedia, storage, graphics and gaming.
> The S5PV310 can be used in products such as Netbooks and Mobile devices.
>
> This patch set consists of the following patches.
>
> [PATCH 1/8] ARM: S5P: Remove fixed uart offset dependent code
> [PATCH 2/8] ARM: S5PV310: Add new CPU initialization support
> [PATCH 3/8] ARM: S5PV310: Add Clock and PLL support
> [PATCH 4/8] ARM: S5PV310: Add IRQ support
> [PATCH 5/8] ARM: S5PV310: Add Timer support
> [PATCH 6/8] ARM: S5PV310: Add new Kconfig and Makefiles
> [PATCH 7/8] ARM: S5PV310: Add Board support file
> [PATCH 8/8] ARM: S5PV310: Add serial port support
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
