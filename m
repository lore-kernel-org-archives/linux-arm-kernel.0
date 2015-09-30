From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Sep 2015 15:15:39 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150930134757.GA18408@gondor.apana.org.au>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
 <20150918151137.GA10763@gondor.apana.org.au>
 <20150918155112.GE3218@x1> <20150929142932.GY27197@x1>
 <20150930134757.GA18408@gondor.apana.org.au>
Message-ID: <20150930141539.GD27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2015, Herbert Xu wrote:
> On Tue, Sep 29, 2015 at 03:29:32PM +0100, Lee Jones wrote:
> > 
> > I see that your tree is 8 days old, so this may have been resolved
> > already, but would you be kind enough to ensure you remove the 6th
> > (ARM) patch from your repo please?  I wouldn't want it to cause
> > conflicts and for Maxime and yourself to get shouted at by Linus.
> 
> I prefer not to merge patches that cannot be tested.  Without
> the DT bits in patch 6 the other five patches are useless.  So
> I think patch 6 should be applied together with the other five
> which add the driver.

That's crazy talk.  If all subsystem maintainers abide by this rule
there would be chaos.  We'd either need to send pull-requests to each
other for every set which crossed a subsystems boundary, or 1000's of
merge conflicts would ensue at merge time.

The (sensible) rule we normally stick to is; as long as there isn't
a _build_ dependency, then the patches should filter though their
respective trees; _functional_ dependencies have nothing to do with
us as maintainers.  Another chaos preventing rule we abide by is; thou
shalt not apply patches belonging to other maintainer's subsystems
without the appropriate Ack-by and a subsequent "you may take this
though your tree" and/or "please send me an immutable pull-request".

> Of course if Linus wants me to revert patch 6 in case of any
> potential conflicts with Maxime's tree I'll do that.  Linus?

Why bother Linus?  The whole purpose of this is to _not_ pi$$ him
off.  This stuff is common sense.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
