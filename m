From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Nov 2016 13:36:02 +0000
Subject: [PATCH] crypto: arm/aesbs - fix brokenness after skcipher
 conversion
In-Reply-To: <20161130131921.GD4126@gondor.apana.org.au>
References: <1480440216-341-1-git-send-email-ard.biesheuvel@linaro.org>
 <20161130131921.GD4126@gondor.apana.org.au>
Message-ID: <53AA8DFA-2420-40D6-A9C2-90B184344819@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> On 30 Nov 2016, at 13:19, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> 
>> On Tue, Nov 29, 2016 at 05:23:36PM +0000, Ard Biesheuvel wrote:
>> The CBC encryption routine should use the encryption round keys, not
>> the decryption round keys.
>> 
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Patch applied.  Thanks.
> 
>> Another fix for the queued changes, this time for 32-bit ARM.
>> 
>> I must say, I'm not impressed with the level of testing that has been
>> carried out after applying these changes. If you had cc'd me on these
>> patches, I would have been happy to test/review.
> 
> Sorry.  I'll make sure you're CCed for ARM patches in future.

Cheers,
Ard.
