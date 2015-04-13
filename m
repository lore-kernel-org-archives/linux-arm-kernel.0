From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 13 Apr 2015 12:13:43 +0800
Subject: [PATCH v2] crypto/arm: accelerated SHA-512 using ARM generic ASM
 and NEON
In-Reply-To: <CAKv+Gu9TU6ETRQDvp7M7Q43xAR5A25scgP3tsvZMmzBQNOK7Cg@mail.gmail.com>
References: <1428676148-28210-1-git-send-email-ard.biesheuvel@linaro.org>
 <F695F357-2A5C-4DFC-9F0E-188CDBBE7C01@linaro.org>
 <CAKv+Gu-6mZwrVSCvS+ZWWwwM-294nWAqX4_J3r5Z8NM7KKC0=Q@mail.gmail.com>
 <2845656.4sNJ3XBxnz@wuerfel>
 <CAKv+Gu9TU6ETRQDvp7M7Q43xAR5A25scgP3tsvZMmzBQNOK7Cg@mail.gmail.com>
Message-ID: <20150413041343.GB11091@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 09:15:10PM +0200, Ard Biesheuvel wrote:
>
> @Herbert: could you please apply this onto cryptodev before sending
> out your pull request for v4.1?

Done.

> And please disregard $subject, I will post a v3 with a similar
> 'depends on' added (unless you're ok to add it yourself)

Please resend the patch.  But I'll process it after the merge
window closes so no hurry.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
