From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:30:30 +0100
Subject: [v5 03/12] soc/fsl/qbman: Use shared-dma-pool for QMan private
 memory allocations
In-Reply-To: <1505767187-4596-4-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-4-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921143030.d6qafcrn4sy5bpap@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:38PM -0400, Roy Pledge wrote:
> Use the shared-memory-pool mechanism for frame queue descriptor and
> packed frame descriptor record area allocations.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
