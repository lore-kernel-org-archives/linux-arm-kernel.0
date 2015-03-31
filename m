From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 31 Mar 2015 21:14:46 +0800
Subject: [PATCH v2 resend 01/14] crypto: sha512: implement base layer for
 SHA-512
In-Reply-To: <1427708913-29678-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1427708913-29678-1-git-send-email-ard.biesheuvel@linaro.org>
 <1427708913-29678-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150331131446.GA17133@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 11:48:20AM +0200, Ard Biesheuvel wrote:
> To reduce the number of copies of boilerplate code throughout
> the tree, this patch implements generic glue for the SHA-512
> algorithm. This allows a specific arch or hardware implementation
> to only implement the special handling that it needs.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Creating yet another module for this is too much.  Please just
add these generic helpers to the generic module.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
