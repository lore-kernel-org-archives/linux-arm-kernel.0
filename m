From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 20 Mar 2017 21:28:58 +0800
Subject: Question - seeding the hw pseudo random number generator
In-Reply-To: <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
References: <20170318092554.lggkhfg5eko23o3k@kozik-lap>
 <CANc+2y5gv2ygSM4HF69XCW7Bb8UUHN+qJKq0os-mOvYknH+SeQ@mail.gmail.com>
Message-ID: <20170320132858.GA27044@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 12:19:32PM +0530, PrasannaKumar Muralidharan wrote:
>
> AF_ALG interface for rng does have seeding support. I think hw_random
> does not provide seeding support intentionally as I understand that
> True RNG need not require seeding (please correct me if I am wrong).

Yes.  We should be converting PRNGs in hwrng over to algif_rng.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
