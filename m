From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 2 Oct 2016 22:46:50 +0800
Subject: [PATCH] crypto: arm64/sha256 - add support for SHA256 using NEON
 instructions
In-Reply-To: <CAKv+Gu_M+FcuDSaGsJYjD96=Q1iXyFDD3KWy=4vUbeLWRgrHJw@mail.gmail.com>
References: <1475189503-9175-1-git-send-email-ard.biesheuvel@linaro.org>
 <1475189503-9175-2-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu8J9rHA2opKqHQr74GU6xxwMpaJak1mNpRVpOf=+BZ81w@mail.gmail.com>
 <CAKv+Gu_M+FcuDSaGsJYjD96=Q1iXyFDD3KWy=4vUbeLWRgrHJw@mail.gmail.com>
Message-ID: <20161002144650.GI18268@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 01, 2016 at 07:58:56PM -0700, Ard Biesheuvel wrote:
>
> Please disregard this patch for now. I will follow up with a more
> elaborate series for SHA256 on arm64

Thanks for the heads up.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
