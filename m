From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 28 Feb 2017 12:14:56 -0800
Subject: [PATCH v4 0/3] Add Broadcom SPU Crypto Driver
In-Reply-To: <CAC3K-4orafSfvi-1E5+sS_c7_2nbU3tzk-QMaJg555q40a-GGg@mail.gmail.com>
References: <1486144534-44887-1-git-send-email-rob.rice@broadcom.com>
 <20170211105404.GF855@gondor.apana.org.au>
 <CAC3K-4orafSfvi-1E5+sS_c7_2nbU3tzk-QMaJg555q40a-GGg@mail.gmail.com>
Message-ID: <9ca122e9-8478-6123-8b92-3d62b68fd374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2017 07:11 AM, Jon Mason wrote:
> On Sat, Feb 11, 2017 at 5:54 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Fri, Feb 03, 2017 at 12:55:31PM -0500, Rob Rice wrote:
>>> Changes in v4:
>>> - Added Rob Herring's Acked-by to patch 1/3 for bindings doc
>>> - In response to Herbert's comment, in ahash_export() and
>>>   ahash_import(), only copy the hash state, not state params
>>>   related to cipher or aead algos.
>>> - Noticed that hmac_offset in iproc_reqctx_s and spu_hash_params
>>>   wasn't really used. So removed.
>>
>> Patches 1-2 applied.  Thanks.
> 
> Thanks Herbert!
> 
> Florian, could you please include patch #3 in your DT branch?

Applied, thanks!
-- 
Florian
