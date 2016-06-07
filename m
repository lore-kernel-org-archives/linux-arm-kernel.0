From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 7 Jun 2016 18:48:21 +0800
Subject: [PATCH 01/28] crypto: omap-aes: Fix registration of algorithms
In-Reply-To: <1464771389-10640-2-git-send-email-t-kristo@ti.com>
References: <1464771389-10640-1-git-send-email-t-kristo@ti.com>
 <1464771389-10640-2-git-send-email-t-kristo@ti.com>
Message-ID: <20160607104821.GA520@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 11:56:02AM +0300, Tero Kristo wrote:
> From: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Algorithms can be registered only once. So skip registration of
> algorithms if already registered (i.e. in case we have two AES cores
> in the system.)
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
