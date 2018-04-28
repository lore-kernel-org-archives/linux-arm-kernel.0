From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 28 Apr 2018 16:24:58 +0800
Subject: [PATCH 06/61] crypto: simplify getting .drvdata
In-Reply-To: <20180419140641.27926-7-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-7-wsa+renesas@sang-engineering.com>
Message-ID: <20180428082458.cpcftonouzrje6gx@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2018 at 04:05:36PM +0200, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/crypto/exynos-rng.c       | 6 ++----
>  drivers/crypto/picoxcell_crypto.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
