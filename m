From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 24 May 2015 16:12:10 +0800
Subject: [linux-sunxi] Re: [PATCH v9 4/4] crypto: Add Allwinner Security
 System crypto accelerator
In-Reply-To: <55618600.6040904@gmail.com>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon> <55607CB7.8020505@gmail.com>
 <20150523163536.2d64ef8d@bbrezillon>
 <20150524033253.GB20656@gondor.apana.org.au>
 <55618600.6040904@gmail.com>
Message-ID: <20150524081210.GA21979@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 24, 2015 at 10:04:16AM +0200, Corentin LABBE wrote:
> 
> For aes_cbc it exists a test with 3 SG with .tap = { 496 - 20, 4, 16 }
> But my driver handle that. (multiple of 4)
> 
> What do you think about adding a test with 16 SG of 1 byte ? (or 3 + 2 + 3 + 8 * 1)

Sure please send a patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
