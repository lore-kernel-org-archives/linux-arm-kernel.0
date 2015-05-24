From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 24 May 2015 11:30:50 +0800
Subject: [linux-sunxi] Re: [PATCH v9 4/4] crypto: Add Allwinner Security
 System crypto accelerator
In-Reply-To: <55606FFE.4000902@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150515064932.GB16704@gondor.apana.org.au>
 <55606FFE.4000902@gmail.com>
Message-ID: <20150524033050.GA20656@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 23, 2015 at 02:18:06PM +0200, Corentin LABBE wrote:
>
> What do you think about adding a BUG_ON(in_atomic()) in crypto_ablkcipher_setkey() ?

Just add a might_sleep() to it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
