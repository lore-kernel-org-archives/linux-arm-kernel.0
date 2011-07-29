From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 29 Jul 2011 10:48:46 +0900
Subject: Question about "Inconsistent kallsyms data"
Message-ID: <02ae01cc4d91$aed71670$0c854350$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

When build with s5pc100_defconfig, happens following.

...
KSYM    .tmp_kallsyms2.S
AS      .tmp_kallsyms2.o
LD      vmlinux
SYSMAP  System.map
SYSMAP  .tmp_System.map
Inconsistent kallsyms data
This is a bug - please report about it
Try make KALLSYMS_EXTRA_PASS=1 as a workaround
make[1]: *** [vmlinux] Error 1
make: *** [sub-make] Error 2

Its HEAD is following (current latest mainline)
(commit 55f9c40ff632d03c527d6a6ceddcda0a224587a6)
Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc

Please kindly let me know how it should be fixed...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
