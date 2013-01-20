From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 20 Jan 2013 11:13:27 +1100
Subject: [PATCH] crypto: omap-sham - Fix compile errors when CONFIG_OF
 not defined
In-Reply-To: <1358283182-29392-1-git-send-email-mgreer@animalcreek.com>
References: <1358283182-29392-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <20130120001327.GE26742@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 01:53:02PM -0700, Mark A. Greer wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Fix the compile errors created by commit 2545e8d
> (crypto: omap-sham - Add Device Tree Support)
> when CONFIG_OF is not defined.  This includes
> changing omap_sham_get_res_dev() to omap_sham_get_res_of()
> and creating an empty version of omap_sham_of_match[].
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

Also applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
