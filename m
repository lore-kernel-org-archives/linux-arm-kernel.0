From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Sep 2016 14:05:53 +0800
Subject: [PATCH] arm64: dts: ls2080a: Add 'dma-coherent' for ls2080a PCI
 nodes
In-Reply-To: <1473301904-27259-1-git-send-email-Gang.Liu@nxp.com>
References: <1473301904-27259-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <20160909060553.GH16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 10:31:44AM +0800, Liu Gang wrote:
> The 'dma-coherent' indicates that the hardware IP block can ensure
> the coherency of the data transferred from/to the IP block. This
> can avoid the software cache flush/invalid actions, and improve
> the performance significantly.
> 
> The PCI IP block of ls2080a has this capability, so adding this
> feature to improve the PCI performance.
> 
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Applied, thanks.
