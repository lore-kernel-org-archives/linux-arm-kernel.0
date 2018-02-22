From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 22 Feb 2018 23:11:38 +0800
Subject: [PATCH] crypto: arm/aes-cipher - move S-box to .rodata section
In-Reply-To: <20180212135237.GA3011@pjb1027-Latitude-E5410>
References: <20180212135237.GA3011@pjb1027-Latitude-E5410>
Message-ID: <20180222151138.GC29815@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 10:52:37PM +0900, Jinbum Park wrote:
> Move the AES inverse S-box to the .rodata section
> where it is safe from abuse by speculation.
> 
> Signed-off-by: Jinbum Park <jinb.park7@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
