From: jdzheng@broadcom.com (JD (Jiandong) Zheng)
Date: Thu, 17 Feb 2011 10:07:45 -0800
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <AANLkTinwQwPK7Lg4dxkLGBxvp1hz489iAB6YrSG45e75@mail.gmail.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
	<AANLkTinwQwPK7Lg4dxkLGBxvp1hz489iAB6YrSG45e75@mail.gmail.com>
Message-ID: <8628FE4E7912BF47A96AE7DD7BAC0AADDDF03CE1D9@SJEXCHCCR02.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 4:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> arch/arm/include/asm/memory.h                  |    2 ++
> arch/arm/kernel/tcm.c                          |    2 +-

> arch/arm/mach-bcmring/include/mach/hardware.h  |    2 +-
> arch/arm/mach-bcmring/include/mach/memory.h    |    2 +-

Acked-by: Jiandong Zheng <jdzheng@broadcom.com>
