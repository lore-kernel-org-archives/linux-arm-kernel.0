From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 23 Mar 2017 17:44:06 +0800
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <20170323082307.GB16625@Red>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
 <20170320132858.GA27044@gondor.apana.org.au>
 <20170323082307.GB16625@Red>
Message-ID: <20170323094406.GA6848@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 09:23:07AM +0100, Corentin Labbe wrote:
> 
> Problem with this conversion, a huge regression for user space.
> Using hwrng is simple as cat /dev/hwrng.
> Using algif_rng via AF_ALG is ... unusable for the moment.
> Perhaps creating an user space tool (prng-tool which provide a cat /dev/hwrng replacement) is mandatory before any convertion.

Stephan may have a tool to do this.  Stephan?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
