From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 20 Nov 2013 19:18:23 +0800
Subject: [PATCH RESEND 0/7] crypto: at91/atmel: add Device Tree support
In-Reply-To: <528C924E.50206@atmel.com>
References: <cover.1383922546.git.nicolas.ferre@atmel.com>
 <528C924E.50206@atmel.com>
Message-ID: <20131120111823.GA20591@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 11:43:26AM +0100, Nicolas Ferre wrote:
> On 08/11/2013 16:08, Nicolas Ferre :
> >This series adds Device Tree support to the Atmel crypto drivers
> >(AES/[T]DES/SHA). The Device Tree entries are very simple and only
> >declare the reg/irq values and the link to DMA.
> 
> Herbert,
> 
> ping?
> 
> Could I have your "Acked-by" for taking these patches through the
> arm-soc git tree, or do you want that we split this series so that
> you can take the driver part of it?

Sure please push them through the arm-soc tree.

You can add my ack:

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
