From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 21 Feb 2011 16:48:34 +1100
Subject: [PATCH] picoxcell_crypto: add support for the picoxcell crypto
	engines
In-Reply-To: <1297776733-17816-1-git-send-email-jamie@jamieiles.com>
References: <1297776733-17816-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110221054834.GB26462@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 01:32:13PM +0000, Jamie Iles wrote:
> Picochip picoXcell devices have two crypto engines, one targeted
> at IPSEC offload and the other at WCDMA layer 2 ciphering.
> 
> v2:	- use symbolic constants for key sizes etc
> 	- cleanup DDT generation
> 	- use strict_strtoul() for stat irq threshold
> 	- minor code cleanups
> 
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>

Patch applied.  Thanks Jamie!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
