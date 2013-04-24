From: viral.vkm@gmail.com (Viral Mehta)
Date: Wed, 24 Apr 2013 23:37:15 +0530
Subject: No subject
Message-ID: <CANX6Damwoz0MSEu5Sb4uKTUhcsC0g+ua1DjuQuMEzXyBOkL7PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am using Marvell's ARMADA XP platform in my development environment.

Recently, I faced DMA related issue. While moving data from memory to
the device, I  found that sometimes I am getting Junk data. I looked
further to see if this is related to DMA Sync problem. So, basically,
I have following questions,

1. As per [1] ARMADA has Coherency Fabric that sits between CPU and
other devices and takes care of hardware based I/O cache coherency. Do
we need to enable any support for the same in software ? I am running
3.0.29 based linux kernel. How do I verify that I have all the things
enabled in Linux Kernel.

2. Do I still need to use dma_[map,unamp]_* APIs while copying data to
and from device ?


[1] http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf

--
Thanks,
Viral Mehta
