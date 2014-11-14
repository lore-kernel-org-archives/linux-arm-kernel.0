From: vichy.kuo@gmail.com (vichy)
Date: Fri, 14 Nov 2014 15:22:01 +0800
Subject: some question about TCR setting
Message-ID: <CAOVJa8HBYkTMCJFKC=+UwjgPp4odm5UV-oUQXu17ctv2+HkpRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi all:
from armv8 spec, no matter TCR_EL1/2/3, there are
1. SH (shareability)
2. ORGN (outer cacheability)
3. IRGN(inner cacheability)

but in the each level block/page descriptor, there are also
sharability, inner, outter, cacheability as well.

What is the difference between the sharability, inner/outer
cacheability between TCR and Block/page descriptors?

Why are there attributes setting keep in TCR?

appreciate your kind help in advance,
