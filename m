From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 10 Mar 2013 18:14:32 +0800
Subject: [PATCH 1/4 v4] ARM: AT91SAM9G45: same platform data structure
 for all crypto peripherals
In-Reply-To: <1361376626-28987-1-git-send-email-nicolas@eukrea.com>
References: <1361376626-28987-1-git-send-email-nicolas@eukrea.com>
Message-ID: <20130310101432.GA10910@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 20, 2013 at 05:10:23PM +0100, Nicolas Royer wrote:
> Only AES use DMA in AT91SAM9G45 (TDES and SHA use PDC).
> 
> However latest Atmel TDES and SHA IP releases use DMA instead of PDC.
>   --> Atmel TDES and SHA drivers need DMA platform data for those IP releases.
> 
> Goal of this patch is to use the same platform data structure for all Atmel
> crypto peripherals. This structure contains information about DMA interface.
> 
> Signed-off-by: Nicolas Royer <nicolas@eukrea.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Eric B?nard <eric@eukrea.com>
> Tested-by: Eric B?nard <eric@eukrea.com>

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
