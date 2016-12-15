From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 15 Dec 2016 14:09:04 +0800
Subject: [PATCH v2] crypto: sun4i-ss: support the Security System PRNG
In-Reply-To: <CANc+2y7C-=S_5MZuqP0Q+y2FwHqS2_p9-iYuAu1A1tXqzxp_oA@mail.gmail.com>
References: <1480934922-20732-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161205123705.GA10732@gondor.apana.org.au>
 <20161205125738.GA13525@Red>
 <20161207120900.GC20680@gondor.apana.org.au>
 <20161207125127.GB28218@Red>
 <20161208090618.GB22932@gondor.apana.org.au>
 <20161213141059.GB10647@Red>
 <20161214050551.GD9592@gondor.apana.org.au>
 <CANc+2y7C-=S_5MZuqP0Q+y2FwHqS2_p9-iYuAu1A1tXqzxp_oA@mail.gmail.com>
Message-ID: <20161215060904.GB13152@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 12:47:16AM +0530, PrasannaKumar Muralidharan wrote:
> Should there be a mandate that driver will be accepted only when it
> passes 'rngtest'. This will make sure that prng drivers won't get
> added in future.

You cannot use software to distinguish between a PRNG and an HRNG.
We can only rely on the veracity of the documentation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
