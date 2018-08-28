From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 28 Aug 2018 15:32:05 +0300
Subject: [PATCH 0/7] ARM32/64: DT overlay build support
Message-ID: <1535459532-17211-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series introduces devicetree overlay building support for ARM
platforms. The .dtbo target is introduced globally, then makefile
changes for both arm32/64 for supporting the .dtbo target, changes
to support sub-dir makefile flags, and finally adding the DTC flags
override for TI platforms, as that is where we want to introduce
the DT overlay support initially.

The ARM makefile changes for supporting DTS sub-makefiles don't look
too clean, but that was the only way I could figure out how to
get it done.

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
