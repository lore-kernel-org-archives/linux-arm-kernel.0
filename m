From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 21 Apr 2010 21:18:01 +0800
Subject: Simply disabling MMU in cpu_v7_reset doesn't work for kexec
Message-ID: <w2mf17812d71004210618vc68963cbn7ed50483a56140b7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tried the following simple code to disable MMU in cpu_v7_reset() doesn't
seem to work for kexec reboot. I was expecting the following instructions
after MMU is disabled are still reachable in the instruction fetching pipe.

Not tried JTAG but posted here early in case anyone knows the correct
sequence of disabling MMU before reset.

- eric
