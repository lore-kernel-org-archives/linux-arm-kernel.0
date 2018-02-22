From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 22 Feb 2018 23:11:49 +0800
Subject: [PATCH] hwrng: bcm2835: Handle deferred clock properly
In-Reply-To: <1518466296-30161-1-git-send-email-stefan.wahren@i2se.com>
References: <1518466296-30161-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20180222151149.GD29815@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 09:11:36PM +0100, Stefan Wahren wrote:
> In case the probe of the clock is deferred, we would assume it is
> optional. This is wrong, so defer the probe of this driver until
> the clock is available.
> 
> Fixes: 791af4f4907a ("hwrng: bcm2835 - Manage an optional clock")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
