From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 22 Jun 2016 18:37:05 +0800
Subject: [[PATCH v2] 11/11] hwrng: exynos - fixup IO accesors
In-Reply-To: <1466504432-24187-12-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20160622103705.GA30967@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> The __raw IO functions are not endian safe, so use the readl_relaxed
> and writel_relaxed versions of these.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

This patch has already been merged.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
