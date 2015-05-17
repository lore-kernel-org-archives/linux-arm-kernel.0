From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 17 May 2015 12:48:11 +0200
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150517103440.GA7800@gondor.apana.org.au>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon>
 <20150517103440.GA7800@gondor.apana.org.au>
Message-ID: <20150517124811.797fab32@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Sun, 17 May 2015 18:34:40 +0800
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> On Sun, May 17, 2015 at 10:45:08AM +0200, Boris Brezillon wrote:
> >
> > From my POV this is not asynchronous at all (see my comments inline),
> > but maybe Herbert can confirm that.
> 
> Well we don't actually require drivers to be asynchronous.  It is
> obviously the preferred method but some hardware may not be capable
> of that.

Yep, but then they shouldn't be declared with CRYPTO_ALG_ASYNC and as an
ablkcipher algorithm (*Asynchronous* Block Cipher), right ?

Regarding the capabilities of this crypto engine, from what I've seen,
it is definitely capable of doing asynchronous requests ;-).

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
