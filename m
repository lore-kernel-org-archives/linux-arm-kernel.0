From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 19 Oct 2016 16:59:59 +0100
Subject: [STLinux Kernel] [PATCH -next] dmaengine: st_fdma: Fix the error
 return code in st_fdma_probe()
In-Reply-To: <1476883430-11970-1-git-send-email-weiyj.lk@gmail.com>
References: <1476883430-11970-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20161019155959.GA1073@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

On Wed, 19 Oct 2016, Wei Yongjun wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function st_slim_rproc_alloc() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should
> be replaced with IS_ERR().
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Good spot.

Acked-by: Peter Griffin <peter.griffin@linaro.org>
