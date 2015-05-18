From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 18 May 2015 08:41:21 +0800
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150517124811.797fab32@bbrezillon>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon>
 <20150517103440.GA7800@gondor.apana.org.au>
 <20150517124811.797fab32@bbrezillon>
Message-ID: <20150518004121.GA11910@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 17, 2015 at 12:48:11PM +0200, Boris Brezillon wrote:
> 
> Yep, but then they shouldn't be declared with CRYPTO_ALG_ASYNC and as an
> ablkcipher algorithm (*Asynchronous* Block Cipher), right ?

Right.  They can still use ablkcipher but should clear the ASYNC
bit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
