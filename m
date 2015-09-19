From: lee.jones@linaro.org (Lee Jones)
Date: Sat, 19 Sep 2015 10:21:45 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150918231213.GA14278@gondor.apana.org.au>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
 <20150918151137.GA10763@gondor.apana.org.au>
 <20150918155112.GE3218@x1>
 <20150918231213.GA14278@gondor.apana.org.au>
Message-ID: <20150919092145.GG3218@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Sep 2015, Herbert Xu wrote:
> On Fri, Sep 18, 2015 at 04:51:12PM +0100, Lee Jones wrote:
> >
> > I think it's okay for you to take all but patch 6.
> > 
> > Patch 6 is an ARM patch and needs to go into ARM SoC via
> > STMicroelectronics STi tree.
> 
> In future please don't send me patches that you don't want me to
> merge in the series.

That's not how it works.  It's helpful, more often than not, to submit
the entire set to each maintainer concerned so they can keep up with
the general conversation.  By only sending specific patches to
maintainers you essentially blinker them to the bigger picture.

As a maintainer you should _know_ that you can't apply patches from
other subsystems without appropriate Acks.  I'm sure you'd take
exception to another maintainer who started accepting patches for
subsystems you are responsible for.  This works both ways.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
