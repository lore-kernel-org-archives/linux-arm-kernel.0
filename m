From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Oct 2014 11:57:33 +0100
Subject: [PATCH v2] arm64: Use DMA_ERROR_CODE to denote failed allocation
In-Reply-To: <1412177510-26310-1-git-send-email-seanpaul@chromium.org>
References: <20141001135248.GQ5182@n2100.arm.linux.org.uk>
 <1412177510-26310-1-git-send-email-seanpaul@chromium.org>
Message-ID: <20141002105732.GB32147@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 04:31:50PM +0100, Sean Paul wrote:
> This patch replaces the static assignment of ~0 to dma_handle with
> DMA_ERROR_CODE to be consistent with other platforms.
> 
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Applied. Thanks.

-- 
Catalin
