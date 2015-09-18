From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 18 Sep 2015 23:11:38 +0800
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
Message-ID: <20150918151137.GA10763@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 03:53:50PM +0100, Lee Jones wrote:
> On 18 September 2015 at 15:07, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > On Thu, Sep 17, 2015 at 02:45:50PM +0100, Lee Jones wrote:
> >> v1 => v2:
> >>  - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
> >>  - Fix 2099 => 2009 typo in commit log
> >>  - Fix 'number of random numbers sourced' return value
> >>  - Treat devm_clk_get()'s return value correctly
> >>  - Check return value of clk_prepare_enable()
> >>  - Use sysfs_streq() instead of manually stripping '\n' from sysfs
> >
> > All applied.  Thanks.
> 
> Just to be clear.  Which patches have you applied?

All of your patches.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
