From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 5 Apr 2013 21:02:39 +0800
Subject: [PATCH] crypto: ux500: add missing comma
In-Reply-To: <1365163595-21926-1-git-send-email-linus.walleij@stericsson.com>
References: <1365163595-21926-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130405130239.GA3181@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 02:06:35PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Commit 4f31f5b19eb0418a847b989abc9ac22af1991fe2
> "PM / crypto / ux500: Use struct dev_pm_ops for power management"
> add a new line to the driver struct but missed to add a
> trailing comma, causing build errors when crypto is
> selected. This adds the missing comma.
> 
> This was not noticed until now because the crypto block
> is not in the ux500 defconfig. A separate patch will
> be submitted to fix this.
> 
> Cc: <stable@vger.kernel.org> # 3.8.x
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Magnus Myrstedt <magnus.p.persson@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
