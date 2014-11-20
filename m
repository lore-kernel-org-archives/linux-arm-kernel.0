From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 20 Nov 2014 22:43:49 +0800
Subject: [PATCH RESEND v2 0/4] hwrng: atmel: add DT support
In-Reply-To: <cover.1416475860.git.nicolas.ferre@atmel.com>
References: <cover.1416475860.git.nicolas.ferre@atmel.com>
Message-ID: <20141120144349.GC32061@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 10:43:21AM +0100, Nicolas Ferre wrote:
> This is the patch series that Boris sent yesterday. I've just collected
> "Acked-by" tags and resend it with updated cover letter.
> 
> This series adds DT support for the TRNG (True Random Generator) block and adds
> missing trng nodes to at91sam9g45 dtsi files.
> 
> Herbert,
> As you said that you can take this series, here is the latest vertion ready for you to
> pick it up. Thanks for your help.
> 
> Bye,
> 
> Boris Brezillon (4):
>   hwrng: atmel: use clk_prepapre_enable/_disable_unprepare
>   hwrng: atmel: add DT support
>   hwrng: atmel: Add TRNG DT binding doc
>   ARM: at91/dt: add trng node to at91sam9g45

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
