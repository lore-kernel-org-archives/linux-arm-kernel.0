From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 2 Oct 2016 22:37:36 +0800
Subject: [PATCH] crypto: sunxi-ss: mark sun4i_hash() static
In-Reply-To: <1474691326-15541-1-git-send-email-baoyou.xie@linaro.org>
References: <1474691326-15541-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20161002143736.GB18268@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2016 at 12:28:46PM +0800, Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/crypto/sunxi-ss/sun4i-ss-hash.c:168:5: warning: no previous prototype for 'sun4i_hash' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> So this patch marks it 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

This patch has already been applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
