From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 28 Dec 2016 09:11:03 +0000
Subject: [PATCH 0/2] crypto: arm64/ARM: NEON accelerated ChaCha20
In-Reply-To: <20161228090350.GD11904@gondor.apana.org.au>
References: <1481207339-17332-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161227100400.GA10629@gondor.apana.org.au>
 <6124F827-BA28-4A3D-B05F-EBCB1323955D@linaro.org>
 <20161228090350.GD11904@gondor.apana.org.au>
Message-ID: <AA6F25FA-C998-462F-9E25-FF543BBE3EA7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 28 Dec 2016, at 09:03, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
>> On Tue, Dec 27, 2016 at 02:26:35PM +0000, Ard Biesheuvel wrote:
>> 
>> You just nacked the v2 of this series (due to the chunksize/walksize) and i rewrote them as skciphers as well
> 
> Sorry.  Would you like me to revert or just send a new series
> on top of this?
> 

No worries. If you can, please drop them entirely, or revert them otherwise. I will resend after the holidays


> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
