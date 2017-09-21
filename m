From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Sep 2017 15:31:26 +0100
Subject: [v5 05/12] soc/fsl/qbman: Drop set/clear_bits usage
In-Reply-To: <1505767187-4596-6-git-send-email-roy.pledge@nxp.com>
References: <1505767187-4596-1-git-send-email-roy.pledge@nxp.com>
 <1505767187-4596-6-git-send-email-roy.pledge@nxp.com>
Message-ID: <20170921143125.yfqswiovu36bal6l@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 04:39:40PM -0400, Roy Pledge wrote:
> From: Madalin Bucur <madalin.bucur@nxp.com>
> 
> Replace PPC specific set/clear_bits API with standard
> bit twiddling so driver is portalable outside PPC.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
