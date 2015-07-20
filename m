From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 20 Jul 2015 16:10:50 +0800
Subject: [PATCH v11] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <1437143983-4479-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1437143983-4479-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20150720081050.GB12908@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 04:39:37PM +0200, LABBE Corentin wrote:
> Hello
> 
> This is the driver for the Security System included in Allwinner SoC A20.
> The Security System (SS for short) is a hardware cryptographic accelerator that
> support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> It could be found on others Allwinner SoC: 
> - A10, A10s, A13, A31 and A33 manual give the same datasheet for SS than A20
> - A23 speak about a security system but without precisions
> - A80 and A83T datasheet speak about a security system with more functions
>   (SHA224/SHA256/RSA/CRC), they will be supported in a separate driver.

All applied.  Thanks a lot!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
