From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri,  4 May 2012 20:30:17 +0800
Subject: [PATCH v2 0/9] support dt for mmp2
Message-ID: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2:
1. remove MACH_MMP_LEGACY & MACH_MMP2_LEGACY
2. use irq.c to replace irq-pxa168.c & irq-mmp2.c
3. Avoid to use CONFIG_OF in entry-macro.S
