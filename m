From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 20 Nov 2018 04:08:19 +0100
Subject: [RFC PATCH] zinc chacha20 generic implementation using crypto API
 code
In-Reply-To: <20181120030635.xfr543j5nngxfnxk@gondor.apana.org.au>
References: <20181105232526.173947-1-ebiggers@kernel.org>
 <20181105232526.173947-11-ebiggers@kernel.org>
 <CAKv+Gu-o0khD5=0EOkv2PiczMs5uZ=XP9V=G2ogBNMK8Kb93sw@mail.gmail.com>
 <20181112185816.GA8663@gmail.com>
 <20181116060227.hwu4igi6bp26ddpi@gondor.apana.org.au>
 <20181117001718.GA175522@gmail.com>
 <CAHmME9rtsCk8ZLt05xRKMGr4CVRnaUvCaVOS_WX3N22HOat4-A@mail.gmail.com>
 <20181119052451.qttzfgcm4hvbdc4u@gondor.apana.org.au>
 <CAHmME9oXAnD0sbO2cKeTtotCMohX2Hu6P=uzA_6u0EWECU9Bpg@mail.gmail.com>
 <20181119225414.GB258711@gmail.com>
 <20181120030635.xfr543j5nngxfnxk@gondor.apana.org.au>
Message-ID: <CAHmME9qxY-LRiik8p3xJGskVAEM2UQj1KdzJnwNGnKghuGvrkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Tue, Nov 20, 2018 at 4:06 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > I'd still prefer to see the conversion patches included.  Skipping them would be
> > kicking the can down the road and avoiding issues that will need to be addressed
> > anyway.  Like you, I don't want a "half-baked concoction that will be maybe
> > possibly be replaced 'later'" :-)
>
> Are you guys talking about the conversion patches to eliminate the
> two copies of chacha code that would otherwise exist in crypto as
> well as in zinc?
>
> If so I think that's not negotiable.  Having two copies of the same
> code is just not acceptable.

Yes, that's the topic. Eric already expressed his preference to keep
them, and I agreed, so the plan is to keep them.

Jason
