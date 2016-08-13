From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 13 Aug 2016 06:37:58 +0300
Subject: =?UTF-8?B?UmU6IFtSRkMgbGludXgtbmV4dF0gQVJNOiBjbHBzNzExeDogdXBkYXRlIGRl?=
 =?UTF-8?B?ZmNvbmZpZw==?=
In-Reply-To: <1471035907-8856-1-git-send-email-fabf@skynet.be>
References: <1471035907-8856-1-git-send-email-fabf@skynet.be>
Message-ID: <1471059478.756841144@f26.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, the configuration has migrated to v4t_multi_defconfig,  so this file could be removed.

>???????, 13 ??????? 2016, 0:05 +03:00 ?? Fabian Frederick <fabf@skynet.be>:
>
>sync defconfig to commit 4a56f46a7dc6
>("ARM: clps711x: Remove boards support")
>
>or maybe we could just remove it ?
>
>Signed-off-by: Fabian Frederick < fabf@skynet.be >
>---
>?arch/arm/configs/clps711x_defconfig | 5 -----
>?1 file changed, 5 deletions(-)
>
>diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
>index fc105c9..64a0ad6 100644
>--- a/arch/arm/configs/clps711x_defconfig
>+++ b/arch/arm/configs/clps711x_defconfig
>@@ -10,11 +10,6 @@ CONFIG_JUMP_LABEL=y
>?CONFIG_PARTITION_ADVANCED=y
>?# CONFIG_IOSCHED_CFQ is not set
>?CONFIG_ARCH_CLPS711X=y
>-CONFIG_ARCH_AUTCPU12=y
>-CONFIG_ARCH_CDB89712=y
>-CONFIG_ARCH_CLEP7312=y
>-CONFIG_ARCH_EDB7211=y
>-CONFIG_ARCH_P720T=y
>?CONFIG_AEABI=y
>?CONFIG_ZBOOT_ROM_TEXT=0x0
>?CONFIG_ZBOOT_ROM_BSS=0x0
>-- 

---
