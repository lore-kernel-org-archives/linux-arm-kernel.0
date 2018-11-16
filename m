From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 16 Nov 2018 14:18:24 +0800
Subject: [PATCH] arm/crypto/aes-ce-glue.c: Remove duplicate header
In-Reply-To: <20181106121614.GA1985@hp-pavilion-15-notebook-pc-brajeswar>
References: <20181106121614.GA1985@hp-pavilion-15-notebook-pc-brajeswar>
Message-ID: <20181116061824.ztwvpgaa7renupz3@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 05:46:14PM +0530, Brajeswar Ghosh wrote:
> Remove asm/hwcap.h which is included more than once
> 
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  arch/arm/crypto/aes-ce-glue.c | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
