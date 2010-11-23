From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 23 Nov 2010 16:07:39 +0800
Subject: 'perf test' failed on ARM
Message-ID: <AANLkTik4QDCD0rAZ=04Ph23ApZ822BBoOWEiPEp7GBNr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

'perf test' is failed on linux 2.6.37-rc2/rc3, follows log info:

root at beagleboard:/mnt/omap/linux-2.6-omap/tools/perf# ./perf test -v 3
 1: vmlinux symtab matches kallsyms:
--- start ---
dso__find_symbol_by_name ---- end ----
vmlinux symtab matches kallsyms: FAILED!

Any suggestions?

-- 
Lei Ming
