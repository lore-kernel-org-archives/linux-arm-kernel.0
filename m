From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 11 Feb 2017 17:39:46 +0800
Subject: [PATCH] crypto: arm/aes-ce: assign err return conditionally
In-Reply-To: <1486560979-25240-1-git-send-email-der.herr@hofr.at>
References: <1486560979-25240-1-git-send-email-der.herr@hofr.at>
Message-ID: <20170211093946.GA749@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 02:36:19PM +0100, Nicholas Mc Guire wrote:
> As the err value is not used unless there was an error it can be assigned
> conditionally here. 
> 
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

This patch just adds noise to the commit history.  So I'm not going
to apply it.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
