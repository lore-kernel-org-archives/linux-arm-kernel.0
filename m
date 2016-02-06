From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 6 Feb 2016 15:49:21 +0800
Subject: [PATCH 0/2] crypto: atmel-sha - fix resource management
In-Reply-To: <cover.1454675769.git.cyrille.pitchen@atmel.com>
References: <cover.1454675769.git.cyrille.pitchen@atmel.com>
Message-ID: <20160206074921.GK22220@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 01:45:11PM +0100, Cyrille Pitchen wrote:
> Hi all,
> 
> these two small patches fix resource release and clock management in
> atomic context.

Applied to crypto.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
