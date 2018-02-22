From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 22 Feb 2018 23:11:18 +0800
Subject: [PATCH] crypto: sunxi-ss: Add MODULE_ALIAS to sun4i-ss
In-Reply-To: <20180211231537.26487-1-pbrobinson@gmail.com>
References: <20180211231537.26487-1-pbrobinson@gmail.com>
Message-ID: <20180222151118.GB29815@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 11, 2018 at 11:15:37PM +0000, Peter Robinson wrote:
> The MODULE_ALIAS is required to enable the sun4i-ss driver to load
> automatically when built at a module. Tested on a Cubietruck.
> 
> Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
