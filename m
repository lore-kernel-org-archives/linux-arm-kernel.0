From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 1 Jun 2017 13:06:41 +0800
Subject: [PATCH 0/5] crypto: arm - enable module autoloading
In-Reply-To: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1495362220-30044-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170601050641.GA12973@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 21, 2017 at 10:23:35AM +0000, Ard Biesheuvel wrote:
> Now that the prerequisite changes are in place, we can modify the
> various accelerated crypto modules that use special instructions to
> expose the CPU feature they depend on. This allows udev to autoload
> the module at boot.

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
