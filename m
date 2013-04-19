From: gang.chen@asianux.com (Chen Gang)
Date: Fri, 19 Apr 2013 19:45:34 +0800
Subject: [Suggestion] ARM64: kernel: compiling issue, need implement cmpxchg64
 with assembler language.
Message-ID: <51712E5E.2020809@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


in arch/arm64/include/asm, not define the function cmpxchg64

  when compiling with allmodconfig,
    drivers/block/blockconsole.c will need this function.

  I am not quite familiar with ARM64 (neither ARM64 assembler)

  can any member helps to send related patch ?
    if no one have time to send related patch, I should try.
    and I am glad to try, but need additional time resources,
    if I try, I should finish it within this month (2013-4-30).

  welcome any suggestions or completions.

  thanks.


gchen.
