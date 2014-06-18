From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jun 2014 10:53:29 +0100
Subject: [PATCH] arm64/dma: Removing ARCH_HAS_DMA_GET_REQUIRED_MASK macro
In-Reply-To: <1402092436-2144-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1402092436-2144-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140618095329.GE11973@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 06, 2014 at 11:07:16PM +0100, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> Arm64 does not define dma_get_required_mask() function.
> Therefore, it should not define the ARCH_HAS_DMA_GET_REQUIRED_MASK.
> This causes build errors in some device drivers (e.g. mpt2sas)
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Applied. Thanks.

-- 
Catalin
