From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 22 Sep 2016 18:45:42 +0800
Subject: [PATCH] crypto: sun4i-ss: mark sun4i_hash() static
In-Reply-To: <1474203164-14884-1-git-send-email-baoyou.xie@linaro.org>
References: <1474203164-14884-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20160922104542.GI5884@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 18, 2016 at 08:52:44PM +0800, Baoyou Xie wrote:
> We get 1 warning when building kernel with W=1:
> drivers/crypto/sunxi-ss/sun4i-ss-hash.c:168:5: warning: no previous prototype for 'sun4i_hash' [-Wmissing-prototypes]
> 
> In fact, this function is only used in the file in which it is
> declared and don't need a declaration, but can be made static.
> So this patch marks it 'static'.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
