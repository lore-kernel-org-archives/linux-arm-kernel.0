From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 22 Jan 2010 09:21:05 +0900
Subject: [PATCH v3 0/9] ARM: S5PV210: Add support for Samsung's S5PV210 CPU
Message-ID: <007101ca9af8$c9d273e0$5d775ba0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch set adds support for Samsung's S5PV210 CPU. The S5PV210 integrates
a ARM Cortex A8 microprocessor with several other peripherals to support
features such as multimedia, storage, graphics and gaming. The S5PV210 can be
used in products such as Netbooks and Mobile devices.

This patch set consists of the following patches.

[PATCH v3 1/9] ARM: S5PV210: Add Samsung S5PV210 CPU support
[PATCH v3 2/9] ARM: S5PV210: Add clock support for S5PV210
[PATCH v3 3/9] ARM: S5PV210: Add IRQ support
[PATCH v3 4/9] ARM: S5PV210: Update Kconfig and Makefiles
[PATCH v3 5/9] ARM: S5PV210: Add SMDKV210 board support file
[PATCH v3 6/9] ARM: S5PV210: Add SMDKC110 board support file
[PATCH v3 7/9] ARM: S5PV210: Add S5PV210 configuration file
[PATCH v3 8/9] ARM: S5PV210: Add S5PC110 configuration file
[PATCH v3 9/9] ARM: S5PV210: Add serial port support


Changes since v2 :

1. Use SPARSEMEM as Russell suggested.
2. Fixed code as per comments from Ben in linux-samsung-soc mailing list.


Changes since v1 :

1. Removed mach/s5pv210/include/mach/gpio-core.h file.
2. Removed unused clock gate defines.
3. Removed machine fixup code from smdkv210 and smdkc110 board support.
4. Merged Kconfig and Makefiles with other source code patches.
5. Replaced multiple definition of UART info with macro.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
