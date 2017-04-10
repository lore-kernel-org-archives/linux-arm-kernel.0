From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 10 Apr 2017 19:22:30 +0800
Subject: [PATCH v2] crypto: arm64/sha: Add constant operand modifier to
 ASM_EXPORT
In-Reply-To: <20170405183458.193068-1-mka@chromium.org>
References: <20170405183458.193068-1-mka@chromium.org>
Message-ID: <20170410112230.GA8800@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 11:34:58AM -0700, Matthias Kaehlcke wrote:
> The operand is an integer constant, make the constness explicit by
> adding the modifier. This is needed for clang to generate valid code
> and also works with gcc.
> 
> Also change the constraint of the operand from 'I' ("Integer constant
> that is valid as an immediate operand in an ADD instruction", AArch64)
> to 'i' ("An immediate integer operand").
> 
> Based-on-patch-from: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Greg Hackmann <ghackmann@google.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
