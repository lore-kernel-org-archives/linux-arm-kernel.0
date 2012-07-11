From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 11 Jul 2012 11:25:37 +0800
Subject: [PATCH 0/5] AT91SAM9G46/M11: add crypto drivers
In-Reply-To: <1341163187-14946-1-git-send-email-eric@eukrea.com>
References: <1341163187-14946-1-git-send-email-eric@eukrea.com>
Message-ID: <20120711032537.GF5263@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 01, 2012 at 07:19:42PM +0200, Eric B?nard wrote:
> This patch serie adds the support for the crypto engine available in
> the Atmel SAM9G46 http://www.atmel.com/devices/SAM9G46.aspx and SAM9M11
> http://www.atmel.com/devices/SAM9M11.aspx
> 
> For each driver the choice between PDC/DMA or PIO was optimized to
> maximize the performances (benchmarks will soon be available on
> the linux4sam wiki http://www.at91.com/).
> 
> These drivers were tested on both devices : the last patch adds a few
> missing tests to tcrypt.
> 
> This work was sponsored by Atmel.

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
