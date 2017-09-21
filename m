From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:32:42 +0100
Subject: [v5 08/12] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
In-Reply-To: <1505767187-4596-9-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-9-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921143242.f3bdqpa4gq6r7dj3@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:43PM -0400, Roy Pledge wrote:
> Rework portal mapping for PPC and ARM. The PPC devices require a
> cacheable coherent mapping while ARM will work with a non-cachable/write
> combine mapping. This also eliminates the need for manual cache
> flushes on ARM. This also fixes the code so sparse checking is clean.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
