From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 19 Oct 2016 22:30:16 +0530
Subject: [PATCH -next] dmaengine: st_fdma: Fix the error return code in
 st_fdma_probe()
In-Reply-To: <1476883430-11970-1-git-send-email-weiyj.lk@gmail.com>
References: <1476883430-11970-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161019170016.GR2467@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 01:23:50PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function st_slim_rproc_alloc() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 

Applied, thanks

-- 
~Vinod
