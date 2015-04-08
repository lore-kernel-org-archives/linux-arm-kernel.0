From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 8 Apr 2015 22:22:08 +0800
Subject: [PATCH v3 01/16] crypto: sha1: implement base layer for SHA-1
In-Reply-To: <CAKv+Gu8_GQuYakxGkqcxh1hX3Ly0gKEqheuh0dgs3SGU-z9Ofw@mail.gmail.com>
References: <1428396724-19962-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428396724-19962-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150408131916.GA29646@gondor.apana.org.au>
 <CAKv+Gu9gQqQEEXgJ=JhVf=7SURx9BfRiaJkakhGv1S9FsqujaQ@mail.gmail.com>
 <20150408133050.GB29646@gondor.apana.org.au>
 <CAKv+Gu-=obTKmviwH9B2wBi==LQa_-aAXVU9QPh1gUeYyopmVw@mail.gmail.com>
 <20150408140633.GA30047@gondor.apana.org.au>
 <CAKv+Gu8_GQuYakxGkqcxh1hX3Ly0gKEqheuh0dgs3SGU-z9Ofw@mail.gmail.com>
Message-ID: <20150408142208.GA30510@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 04:18:56PM +0200, Ard Biesheuvel wrote:
>
> So what about
> 
> > +typedef void (sha1_block_fn)(int blocks, u8 const *src, u32 *state,
> > +                          bool final);
> 
> ?

Looks good to me.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
