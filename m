From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 14 Oct 2015 22:28:22 +0800
Subject: [PATCH 0/3] hwrng: stm32 - add support for STM32 HW RNG
In-Reply-To: <1444638090-22886-1-git-send-email-daniel.thompson@linaro.org>
References: <1443904519-24012-1-git-send-email-daniel.thompson@linaro.org>
 <1444638090-22886-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20151014142822.GF17455@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 09:21:27AM +0100, Daniel Thompson wrote:
> This patchset introduces a driver for the STM32 hardware random number
> generator.
> 
> v2:
> 
>  * Moved binding docs from .../hwrng/ to .../rng/ and renamed to match
>    convention in new directory (Rob Herring).
>  * Adopted runtime PM and auto-suspend instead of managing the clocks
>    from the read function (Linus Walleij). Increased bandwidth by ~30%.
>  * Simplified error detection in main read loop (Linus Walleij, Maxime
>    Coquelin).
>  * Only WARN_ONCE() when hardware failure mechanisms trigger (Maxime
>    Coquelin).
>  * Simplify end of probe function after cocci warning (Fengguang Wu).
>  * Switch to devm_hwrng_register.

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
