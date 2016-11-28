From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 28 Nov 2016 19:58:43 +0800
Subject: [PATCH v4] crypto: arm64/sha2: integrate OpenSSL implementations
 of SHA256/SHA512
In-Reply-To: <CAKv+Gu9RVFQ4SNzbHbNCFSXy01b+_dCeRc4bXgZagovGy9BYtQ@mail.gmail.com>
References: <1479642121-17912-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9SG5s=zddQaw+444191JGqmXfCh+AKyv3nZNqggmh=Kw@mail.gmail.com>
 <CAKv+Gu9RVFQ4SNzbHbNCFSXy01b+_dCeRc4bXgZagovGy9BYtQ@mail.gmail.com>
Message-ID: <20161128115843.GA2257@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2016 at 09:50:33AM +0000, Ard Biesheuvel wrote:
>
> Assuming that everyone is happy now (Will?), could we get this one
> queued for v4.10? The CRC stuff I sent over the past week can wait for
> v4.11 (and I should probably do a v2 roundup with everything
> combined), but this patch is good to go IMO

Sorry, I overlooked it because it wasn't in patchwork.  I have
applied it now and will push it out soon.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
