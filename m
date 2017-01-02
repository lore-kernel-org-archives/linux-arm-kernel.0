From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 2 Jan 2017 10:54:43 +0530
Subject: [PATCH 1/3] dma: zx: rename zx296702_dma.c to zx_dma.c
In-Reply-To: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
References: <1481810617-7650-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170102052443.GS3573@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 10:03:35PM +0800, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> ZTE ZX dma driver is not ZX296702 specific.  It works for not only
> ZX296702 but also other ZTE ZX family platforms like ZX296718.  Let's
> rename the file to reflect that.

Applied all after fixing subsystem name

-- 
~Vinod
