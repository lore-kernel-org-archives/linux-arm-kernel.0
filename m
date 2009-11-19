From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 09:03:28 +0000
Subject: Can anyone help test Cortex A9 patches?
Message-ID: <20091119090328.GC13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I need help testing Cortex A9 patches.  What I need is someone with a
fairly fully fledged Cortex A9 platform with the ability to build and
test recent kernels - and therefore be able to test my patches without
modification.

Specifically, I'm looking for someone who can reproduce data corruption
on DMA transfers from devices caused by Cortex A9's speculative prefetching

Unfortunately, I have no way to reproduce this problem here (I have no
Cortex A9 hardware), and as such I can't test the fixes.
