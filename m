From: eric.y.miao@gmail.com (eric.y.miao at gmail.com)
Date: Mon, 9 Aug 2010 09:57:40 +0800
Subject: [ERROR] kgdb: GDB_MAX_REGS not defined
Message-ID: <AANLkTimaSFG7ad6=NC9VB_S7hx+Y7SZ8ktxjJDo-NeEF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

/home/ycmiao/linux-2.6/arch/arm/kernel/kgdb.c: In function
'sleeping_thread_to_gdb_regs':
/home/ycmiao/linux-2.6/arch/arm/kernel/kgdb.c:82: error:
'GDB_MAX_REGS' undeclared (first use in this function)
/home/ycmiao/linux-2.6/arch/arm/kernel/kgdb.c:82: error: (Each
undeclared identifier is reported only once
/home/ycmiao/linux-2.6/arch/arm/kernel/kgdb.c:82: error: for each
function it appears in.)
make[2]: *** [arch/arm/kernel/kgdb.o] Error 1
make[1]: *** [arch/arm/kernel] Error 2
make: *** [sub-make] Error 2
