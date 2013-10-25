From: Jens.Meier@huawei.com (Jens Meier)
Date: Fri, 25 Oct 2013 11:39:34 +0000
Subject: arm64: add ftrace support
Message-ID: <ED7794875F7BEB4F95284BF9597F2D902D1CC5A8@lhreml512-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I had some problems applying/compiling Akashi?s ftrace patches.
- There is an invocation of insn.o missing in the first Makefile patch
- <asm/insn.h> is missing in the patch set as well as in the latest upstream kernel although included from ftrace.c

Best Regards
Jens
