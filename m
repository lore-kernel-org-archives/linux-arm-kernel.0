From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:30:06 +0100
Subject: [v5 02/12] soc/fsl/qbman: Use shared-dma-pool for BMan private
 memory allocations
In-Reply-To: <1505767187-4596-3-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-3-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921143006.fip7d7ynmc6m3p5p@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:37PM -0400, Roy Pledge wrote:
> Use the shared-memory-pool mechanism for free buffer proxy record
> area allocation.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
