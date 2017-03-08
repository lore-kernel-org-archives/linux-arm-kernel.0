From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 8 Mar 2017 12:41:37 +0100
Subject: [PATCH -next] soc: zte: pm_domains: Remove redundant dev_err
 call in zx2967_pd_probe()
In-Reply-To: <20170206162302.15611-1-weiyj.lk@gmail.com>
References: <20170206162302.15611-1-weiyj.lk@gmail.com>
Message-ID: <20170308114135.GB12997@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 04:23:02PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied, thanks.
