From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:16:59 -0800
Subject: [Request pull] mvebu/soc #2
In-Reply-To: <20150122004045.GB9533@lunn.ch>
References: <20150122004045.GB9533@lunn.ch>
Message-ID: <20150123221659.GI20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 01:40:45AM +0100, Andrew Lunn wrote:
> Hi Olof
> 
> Here is the second incremental pull request for mvebu/soc.
> 
> Note these depend on mvebu-fixes-3.19-4, which in turn depends on
> v3.19-rc4.
> 
> 	Andrew
> 
> 
> The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:
> 
>   linux 3.19-rc4 (2015-01-11 12:44:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.20-2
> 
> for you to fetch changes up to 1737cac6936938a9bc52c03c4a3ff2032c702fa5:
> 
>   bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window (2015-01-19 16:09:16 -0600)
> 
> ----------------------------------------------------------------
> Soc patches for mvebu for v3.20, part #2.
> 
> Note these depend on mvebu-fixes-3.19-4, which in turn depends on
> v3.19-rc4.
> 
> bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window
> bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x
> ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware I/O coherency
> bus: mvebu-mbus: use automatic I/O synchronization barriers

Merged, but see comments about tag contents from the fixes branch.

-Olof
