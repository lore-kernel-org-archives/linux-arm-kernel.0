From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 20 Sep 2015 09:23:48 +0800
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
In-Reply-To: <20150919092145.GG3218@x1>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150918140756.GK9249@gondor.apana.org.au>
 <CAF2Aj3h7Jy=tpYdZTdbxAJwa=147_hAu3reOFrbEh=JdrMFWLQ@mail.gmail.com>
 <20150918151137.GA10763@gondor.apana.org.au>
 <20150918155112.GE3218@x1>
 <20150918231213.GA14278@gondor.apana.org.au>
 <20150919092145.GG3218@x1>
Message-ID: <20150920012347.GA21913@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 19, 2015 at 10:21:45AM +0100, Lee Jones wrote:
>
> That's not how it works.  It's helpful, more often than not, to submit
> the entire set to each maintainer concerned so they can keep up with
> the general conversation.  By only sending specific patches to
> maintainers you essentially blinker them to the bigger picture.
> 
> As a maintainer you should _know_ that you can't apply patches from
> other subsystems without appropriate Acks.  I'm sure you'd take
> exception to another maintainer who started accepting patches for
> subsystems you are responsible for.  This works both ways.

No you are mistaken.  You should only put patches which have
dependencies on each other in a series.  If the patches can be
applied independently of each other there is no need to have
them in a single series.

Obviously if they can go into different trees then they cannot
have dependencies.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
