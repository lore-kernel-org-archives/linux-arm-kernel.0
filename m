From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 20 Mar 2018 07:36:32 +0800
Subject: [PATCH v5 00/23] crypto: arm64 - play nice with CONFIG_PREEMPT
In-Reply-To: <CAKv+Gu8jCa7dAoXHan+3zwBt2pZjD22MaCSwiAM-bXHgvVJkmQ@mail.gmail.com>
References: <20180310152208.10369-1-ard.biesheuvel@linaro.org>
 <20180316155735.GJ7095@gondor.apana.org.au>
 <CAKv+Gu8jCa7dAoXHan+3zwBt2pZjD22MaCSwiAM-bXHgvVJkmQ@mail.gmail.com>
Message-ID: <20180319233631.GB15897@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 11:31:24PM +0800, Ard Biesheuvel wrote:
>
> Apologies if this wasn't clear, but there are some cross dependencies
> with the arm64 tree, which receives non-trivial modifications in
> patches 10 and 11, which are subsequently depended upon by patches 12
> - 23.
> 
> Without acks from them, we should really not be merging this code yet,
> especially because I noticed a rebase issue in patch #10 (my bad).
> 
> Would you mind reverting 10 - 22? I will revisit this asap, and try to
> get acks for the arm64 patches. If that means waiting for the next
> cycle, so be it.

Sure it's done now.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
