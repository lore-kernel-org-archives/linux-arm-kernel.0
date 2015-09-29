From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Sep 2015 15:29:32 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150918155112.GE3218@x1>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
 <20150918151137.GA10763@gondor.apana.org.au>
 <20150918155112.GE3218@x1>
Message-ID: <20150929142932.GY27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Sep 2015, Lee Jones wrote:
> On Fri, 18 Sep 2015, Herbert Xu wrote:
> > On Fri, Sep 18, 2015 at 03:53:50PM +0100, Lee Jones wrote:
> > > On 18 September 2015 at 15:07, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > > On Thu, Sep 17, 2015 at 02:45:50PM +0100, Lee Jones wrote:
> > > >> v1 => v2:
> > > >>  - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
> > > >>  - Fix 2099 => 2009 typo in commit log
> > > >>  - Fix 'number of random numbers sourced' return value
> > > >>  - Treat devm_clk_get()'s return value correctly
> > > >>  - Check return value of clk_prepare_enable()
> > > >>  - Use sysfs_streq() instead of manually stripping '\n' from sysfs
> > > >
> > > > All applied.  Thanks.
> > > 
> > > Just to be clear.  Which patches have you applied?
> > 
> > All of your patches.
> 
> I think it's okay for you to take all but patch 6.
> 
> Patch 6 is an ARM patch and needs to go into ARM SoC via
> STMicroelectronics STi tree.

Hi Herbert,

I see that your tree is 8 days old, so this may have been resolved
already, but would you be kind enough to ensure you remove the 6th
(ARM) patch from your repo please?  I wouldn't want it to cause
conflicts and for Maxime and yourself to get shouted at by Linus.

Much appreciated.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
