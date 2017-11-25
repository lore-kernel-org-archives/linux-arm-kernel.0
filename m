From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 25 Nov 2017 11:17:35 +1100
Subject: [PATCH v3] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <12422115.UWn9hbrTTi@tauon.chronox.de>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <1966139.WIlnTlQG5u@positron.chronox.de>
 <20171124073739.GB15597@gondor.apana.org.au>
 <12422115.UWn9hbrTTi@tauon.chronox.de>
Message-ID: <20171125001735.GC20780@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 24, 2017 at 05:04:19PM +0100, Stephan Mueller wrote:
>
> Would it make sense to feed it to stable?

I already added stable Cc's so it should go in automatically once
it's pushed to Linus.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
