From: raghumag@gmail.com (raghu MG)
Date: Tue, 19 May 2015 01:32:23 +0530
Subject: ARMADA XP MV78260
Message-ID: <CAG1O52X9XOMjHrBLYXcCuDnN9_3V8awUWGSBysS7JFFG8a=Nxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

.Hi,
This mail is regarding Linux smp boot on ARMADA-XP MV2860.

CPU-1 doesnt boot/go through the boot sequence & it fails to come
online & dumps this message

CPU1:failed to come online .

The CPU-1 boot register is programmed with physical address of
-->armada_xp_secondary_startup function & then cpu-0 deasserts the CPU-1.

I am using armada-xp-gp.dts with armada-xp-mv78260.dts included in it.

Any help would be appreciated.
Regards

CPU-1 doesnt boot/go through the boot sequence & it fails to come
online & dumps this message

CPU1:failed to come online .

The CPU-1 boot register is programmed with physical address of
-->armada_xp_secondary_startup function & then cpu-0 deasserts the CPU-1.

I am using armada-xp-gp.dts with armada-xp-mv78260.dts included in it.

Any help would be appreciated.
Regards
