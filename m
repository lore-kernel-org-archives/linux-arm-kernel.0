From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 9 Jan 2015 16:52:04 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20150109165204.3d0d3d99@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Tue, 30 Dec 2014 13:43:41 +0100, Thomas Petazzoni wrote:

> Michal Mazur (1):
>   bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x
> 
> Thomas Petazzoni (5):
>   dt: bindings: update mvebu-mbus DT binding with new compatible
>     properties
>   ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada
>     38x
>   bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus
>     bridge window
>   bus: mvebu-mbus: use automatic I/O synchronization barriers
>   ARM: mvebu: use arm_coherent_dma_ops

Would it be possible to get those patches applied?

Simon has started doing some testing with the automatic I/O sync
barriers. It is still not working 100% properly, but it is apparently
not worse than it was. And clearly the current situation is not good,
and those patches make it slightly better.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
