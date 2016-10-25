From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 25 Oct 2016 11:43:41 +0800
Subject: [PATCH] hwrng: meson: Remove unneeded platform MODULE_ALIAS
In-Reply-To: <1476906618-14455-1-git-send-email-javier@osg.samsung.com>
References: <1476906618-14455-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20161025034341.GI18685@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 04:50:18PM -0300, Javier Martinez Canillas wrote:
> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
> 
> So there's no need to have a MODULE_ALIAS("platform:meson-rng") since
> the reported uevent MODALIAS to user-space will always be the OF one.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
