From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 5 Oct 2010 08:45:47 +0900
Subject: [PATCH 0/7] ARM: S5PC210: I2C devices support and Universal board
	updates
In-Reply-To: <20100930044814.GA16892@july>
References: <20100930044814.GA16892@july>
Message-ID: <AANLkTiknkbts6AtiBpqceSDqEXsE9E+qpMKJx2fzygB6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I think we made some conclusion. first apply the current style and
improve it later for consistency.

Thank you,
Kyungmin Park

On Thu, Sep 30, 2010 at 1:48 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> The following changes since commit aff078a9da27e0effb2a149834089e5788943d4b:
> ?Marek Szyprowski (1):
> ? ? ? ?ARM: S5PV210: Enable USB HSOTG gadget build
>
> Kyungmin Park (7):
> ? ? ?ARM: S5PC210: Universal OneNAND support
> ? ? ?ARM: S5PC110: Fix wrong interrupt I2C2 number
> ? ? ?ARM: Samsung: Use the correct I2C2 interrupt
> ? ? ?ARM: S5PC210: I2C1/2 support
> ? ? ?ARM: S5PC210: I2C0/1 devices support on Universal board
> ? ? ?ARM: S5PC210: Define the more I2C{3,4,5,6,7} address & interrupt
> ? ? ?ARM: S5PC210: I2C{3, 4, 5, 6, 7} device support
>
> ?arch/arm/mach-s5pv210/include/mach/irqs.h ? | ? ?4 +-
> ?arch/arm/mach-s5pv310/Kconfig ? ? ? ? ? ? ? | ? 18 +++++++
> ?arch/arm/mach-s5pv310/Makefile ? ? ? ? ? ? ?| ? ?5 ++
> ?arch/arm/mach-s5pv310/include/mach/irqs.h ? | ? ?7 +++
> ?arch/arm/mach-s5pv310/include/mach/map.h ? ?| ? 11 ++++-
> ?arch/arm/mach-s5pv310/mach-universal_c210.c | ? 16 ++++++
> ?arch/arm/mach-s5pv310/setup-i2c3.c ? ? ? ? ?| ? 25 ++++++++++
> ?arch/arm/mach-s5pv310/setup-i2c4.c ? ? ? ? ?| ? 25 ++++++++++
> ?arch/arm/mach-s5pv310/setup-i2c5.c ? ? ? ? ?| ? 25 ++++++++++
> ?arch/arm/mach-s5pv310/setup-i2c6.c ? ? ? ? ?| ? 25 ++++++++++
> ?arch/arm/mach-s5pv310/setup-i2c7.c ? ? ? ? ?| ? 25 ++++++++++
> ?arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? | ? 25 ++++++++++
> ?arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ?| ? ?5 ++
> ?arch/arm/plat-s5p/dev-i2c3.c ? ? ? ? ? ? ? ?| ? 67 +++++++++++++++++++++++++++
> ?arch/arm/plat-s5p/dev-i2c4.c ? ? ? ? ? ? ? ?| ? 67 +++++++++++++++++++++++++++
> ?arch/arm/plat-s5p/dev-i2c5.c ? ? ? ? ? ? ? ?| ? 67 +++++++++++++++++++++++++++
> ?arch/arm/plat-s5p/dev-i2c6.c ? ? ? ? ? ? ? ?| ? 67 +++++++++++++++++++++++++++
> ?arch/arm/plat-s5p/dev-i2c7.c ? ? ? ? ? ? ? ?| ? 67 +++++++++++++++++++++++++++
> ?arch/arm/plat-samsung/dev-i2c2.c ? ? ? ? ? ?| ? ?4 +-
> ?arch/arm/plat-samsung/include/plat/iic.h ? ?| ? ?5 ++
> ?20 files changed, 554 insertions(+), 6 deletions(-)
> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c3.c
> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c4.c
> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c5.c
> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c6.c
> ?create mode 100644 arch/arm/mach-s5pv310/setup-i2c7.c
> ?create mode 100644 arch/arm/plat-s5p/dev-i2c3.c
> ?create mode 100644 arch/arm/plat-s5p/dev-i2c4.c
> ?create mode 100644 arch/arm/plat-s5p/dev-i2c5.c
> ?create mode 100644 arch/arm/plat-s5p/dev-i2c6.c
> ?create mode 100644 arch/arm/plat-s5p/dev-i2c7.c
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
