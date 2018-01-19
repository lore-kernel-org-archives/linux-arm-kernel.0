From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 19 Jan 2018 11:08:54 +0530
Subject: [PATCH -next] dmaengine: stm32-dmamux: Remove unnecessary
 platform_get_resource() error check
In-Reply-To: <1516188430-145326-1-git-send-email-weiyongjun1@huawei.com>
References: <1516188430-145326-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <20180119053854.GU18649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 17, 2018 at 11:27:10AM +0000, Wei Yongjun wrote:
> devm_ioremap_resource() already checks if the resource is NULL, so
> remove the unnecessary platform_get_resource() error check.

Applied, thanks

-- 
~Vinod
