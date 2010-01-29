From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 29 Jan 2010 11:27:32 +0900
Subject: [PATCH v2 0/7] ARM: S5P6442: Add support for Samsung's S5P6442 SoC
Message-ID: <000301caa08a$9f6a3830$de3ea890$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This patches add basic support for Samsung's S5P6442 SoC.
The feature set that is added are clock, timer, uart and interrupts.

[PATCH v2 1/7] ARM: S5P6442: Add Samsung S5P6442 CPU support
[PATCH v2 2/7] ARM: S5P6442: Add clock support for S5P6442
[PATCH v2 3/7] ARM: S5P6442: Add IRQ support
[PATCH v2 4/7] ARM: S5P6442: Update Kconfig and Makefiles
[PATCH v2 5/7] ARM: S5P6442: Add SMDK6442 board support file
[PATCH v2 6/7] ARM: S5P6442: Add S5P6442 configuration file
[PATCH v2 7/7] ARM: S5P6442: Add serial port support

Changes since v1:
1. Common macros are used such as S3C_PA_XXX and S3C_VA_XXX
2. Renamed S5P_VA_VICx definitions as VA_VICx
3. Removed unnecessary definitions in the header files like map.h
4. Added VIC2 definitions.
5. Fixed code as per comments from Ben in linux-samsung-soc mailing list.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
