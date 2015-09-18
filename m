From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Sep 2015 15:53:50 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150918140756.GK9249@gondor.apana.org.au>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
Message-ID: <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 September 2015 at 15:07, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Sep 17, 2015 at 02:45:50PM +0100, Lee Jones wrote:
>> v1 => v2:
>>  - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
>>  - Fix 2099 => 2009 typo in commit log
>>  - Fix 'number of random numbers sourced' return value
>>  - Treat devm_clk_get()'s return value correctly
>>  - Check return value of clk_prepare_enable()
>>  - Use sysfs_streq() instead of manually stripping '\n' from sysfs
>
> All applied.  Thanks.

Just to be clear.  Which patches have you applied?

> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Lee Jones
Linaro ST Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
