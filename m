From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 13 Feb 2017 10:11:40 -0500
Subject: [PATCH v4 0/3] Add Broadcom SPU Crypto Driver
In-Reply-To: <20170211105404.GF855@gondor.apana.org.au>
References: <1486144534-44887-1-git-send-email-rob.rice@broadcom.com>
 <20170211105404.GF855@gondor.apana.org.au>
Message-ID: <CAC3K-4orafSfvi-1E5+sS_c7_2nbU3tzk-QMaJg555q40a-GGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2017 at 5:54 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Fri, Feb 03, 2017 at 12:55:31PM -0500, Rob Rice wrote:
>> Changes in v4:
>> - Added Rob Herring's Acked-by to patch 1/3 for bindings doc
>> - In response to Herbert's comment, in ahash_export() and
>>   ahash_import(), only copy the hash state, not state params
>>   related to cipher or aead algos.
>> - Noticed that hmac_offset in iproc_reqctx_s and spu_hash_params
>>   wasn't really used. So removed.
>
> Patches 1-2 applied.  Thanks.

Thanks Herbert!

Florian, could you please include patch #3 in your DT branch?

Thanks,
Jon

> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
