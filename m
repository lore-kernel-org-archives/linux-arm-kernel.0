From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 8 Oct 2015 22:23:40 +0800
Subject: [PATCH v2 0/3] hwrng: st: Couple of improvements
In-Reply-To: <1444220609-31251-1-git-send-email-lee.jones@linaro.org>
References: <1444220609-31251-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20151008142340.GD25166@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 01:23:26PM +0100, Lee Jones wrote:
> This set contains a minor documentation fix, greater clarification
> with how the FIFO depth/size is represented and finally a fix to
> prevent early timeout during data acquisition.
> 
> v1 => v2:
>  - Remove phantom bugfix (FIFO really is 4 deep, not 8)
>  - Double timeout value to account for inconsistent call to udelay()
>    - Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
