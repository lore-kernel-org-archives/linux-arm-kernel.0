From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 1 Feb 2016 16:22:01 +0800
Subject: [PATCH v2] crypto: atmel-sha: fix algorihtm registration
In-Reply-To: <da09591cf85a1882817bbf7cb527bb228d3f8f87.1454082992.git.cyrille.pitchen@atmel.com>
References: <da09591cf85a1882817bbf7cb527bb228d3f8f87.1454082992.git.cyrille.pitchen@atmel.com>
Message-ID: <20160201082201.GE5818@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2016 at 05:04:02PM +0100, Cyrille Pitchen wrote:
> This patch implements the missing .import() and .export() mandatory
> hooks for asynchronous hash algorithms. It also sets the relevant, non
> zero, value for the .statesize field when declaring the supported SHA
> algorithms. Indeed a zero value of .statesize prevents the algorithm from
> being registered.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
