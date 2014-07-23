From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 23 Jul 2014 21:16:20 +0800
Subject: [PATCH v4 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1405169953-13695-4-git-send-email-clabbe.montjoie@gmail.com>
References: <1405169953-13695-1-git-send-email-clabbe.montjoie@gmail.com>
 <1405169953-13695-4-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20140723131620.GC29178@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 12, 2014 at 02:59:13PM +0200, LABBE Corentin wrote:
> Add support for the Security System included in Allwinner SoC A20.
> The Security System is a hardware cryptographic accelerator that support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

This is essentially a synchronous driver, no? If so please
switch to the blkcipher/shash interface.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
