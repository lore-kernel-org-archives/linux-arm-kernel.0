From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 28 Dec 2016 17:03:50 +0800
Subject: [PATCH 0/2] crypto: arm64/ARM: NEON accelerated ChaCha20
In-Reply-To: <6124F827-BA28-4A3D-B05F-EBCB1323955D@linaro.org>
References: <1481207339-17332-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161227100400.GA10629@gondor.apana.org.au>
 <6124F827-BA28-4A3D-B05F-EBCB1323955D@linaro.org>
Message-ID: <20161228090350.GD11904@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 27, 2016 at 02:26:35PM +0000, Ard Biesheuvel wrote:
>
> You just nacked the v2 of this series (due to the chunksize/walksize) and i rewrote them as skciphers as well

Sorry.  Would you like me to revert or just send a new series
on top of this?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
