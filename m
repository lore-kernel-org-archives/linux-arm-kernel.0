From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 13 Sep 2016 20:41:28 +0800
Subject: [PATCH -next] hwrng: st - Fix missing clk_disable_unprepare() on
 error in st_rng_probe()
In-Reply-To: <1473509022-3478-1-git-send-email-weiyj.lk@gmail.com>
References: <1473509022-3478-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160913124128.GE31835@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 10, 2016 at 12:03:42PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix the missing clk_disable_unprepare() before return
> from st_rng_probe() in the error handling case.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
