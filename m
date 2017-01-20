From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Jan 2017 08:34:29 -0500
Subject: [PATCH 1/3 v2] ahci: qoriq: added a condition to enable dma
 coherence
In-Reply-To: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
References: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <20170120133429.GB31487@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 02:59:34PM +0800, yuantian.tang at nxp.com wrote:
> From: Tang Yuantian <Yuantian.Tang@nxp.com>
> 
> Enable DMA coherence in SATA controller on condition that
> dma-coherent property exists in sata node in DTS.
> 
> Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>

Applied to libata/for-4.11.

Thanks.

-- 
tejun
