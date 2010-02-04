From: dirk.behme@googlemail.com (Dirk Behme)
Date: Thu, 04 Feb 2010 17:47:12 +0100
Subject: CONFIG_SMP: Status of pending patches?
Message-ID: <4B6AFA10.9060004@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Regarding two of Catalin's CONFIG_SMP patches in linux-arm git, I 
wonder what's the recent status regarding mainline inclusion? The two 
patches

1. Global ASID allocation on SMP
http://www.linux-arm.org/git?p=linux-2.6.git;a=commit;h=33618544e3151700950707c920ea2f7ec3e0b7ba

2. ARM: Implement read/write for ownership in the ARMv6 DMA cache ops
http://www.linux-arm.org/git?p=linux-2.6.git;a=commit;h=1bb211d4b81d65760d6befb17a01348db79459b1

seem to be essential for SMP stability.

Patch (1) is marked as applied [1]. Will it be part of final 2.6.33? 
For patch (2) I couldn't find anything. Is planned for mainline 
inclusion, too?

Sorry if I missed anything.

Thanks

Dirk

[1] http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5905/1
