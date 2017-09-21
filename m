From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:31:50 +0100
Subject: [v5 06/12] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
In-Reply-To: <1505767187-4596-7-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-7-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921143150.vkr4oerrbzlqdmes@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:41PM -0400, Roy Pledge wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> Not relevant and arch dependent. Overkill for PPC.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
