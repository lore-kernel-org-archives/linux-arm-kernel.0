From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 21 Oct 2016 11:09:45 +0800
Subject: [PATCH 1/1] crypto: atmel-aes: fix compiler error when
 VERBOSE_DEBUG is defined
In-Reply-To: <605a4f64ee501aeaffbd43b7b45fd9b3d997bd7b.1475167206.git.cyrille.pitchen@atmel.com>
References: <605a4f64ee501aeaffbd43b7b45fd9b3d997bd7b.1475167206.git.cyrille.pitchen@atmel.com>
Message-ID: <20161021030945.GB22979@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2016 at 06:46:57PM +0200, Cyrille Pitchen wrote:
> This patch fixes a compiler error when VERBOSE_DEBUG is defined. Indeed,
> in atmel_aes_write(), the 3rd argument of atmel_aes_reg_name() was
> missing.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Reported-by: Levent Demir <levent.demir@inria.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
