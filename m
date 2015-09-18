From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 18 Sep 2015 22:07:56 +0800
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150918140756.GK9249@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 02:45:50PM +0100, Lee Jones wrote:
> v1 => v2:
>  - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
>  - Fix 2099 => 2009 typo in commit log
>  - Fix 'number of random numbers sourced' return value
>  - Treat devm_clk_get()'s return value correctly
>  - Check return value of clk_prepare_enable()
>  - Use sysfs_streq() instead of manually stripping '\n' from sysfs

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
