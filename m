From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 08:43:41 +0800
Subject: [PATCH] PCI: layerscape: Add 'dma-coherent' property
In-Reply-To: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
References: <1465282546-28256-1-git-send-email-Gang.Liu@nxp.com>
Message-ID: <20160616004341.GK20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 02:55:45PM +0800, Liu Gang wrote:
> Add 'dma-coherent' description for PCI nodes.
> 
> The 'dma-coherent' indicates that the hardware IP block can ensure
> the coherency of the data transferred from/to the IP block. This
> can avoid the software cache flush/invalid actions, and improve
> the performance significantly.
> 
> The PCI IP block of ls1043a has this capability, so adding
> this feature to improve the PCI performance.
> 
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Applied both, thanks.
