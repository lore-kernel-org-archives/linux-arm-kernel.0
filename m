From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 30 Apr 2017 01:54:04 +0800
Subject: [PATCH -next] crypto: stm32 - Fix OF module alias information
In-Reply-To: <20170425143542.1069-1-weiyj.lk@gmail.com>
References: <20170425143542.1069-1-weiyj.lk@gmail.com>
Message-ID: <20170429175404.GA11788@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 25, 2017 at 02:35:42PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The module alias information passed to MODULE_DEVICE_TABLE()
> should use stm32_dt_ids instead of undefined sti_dt_ids.
> 
> Fixes: b51dbe90912a ("crypto: stm32 - Support for STM32 CRC32 crypto module")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
