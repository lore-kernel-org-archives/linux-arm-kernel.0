From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 21 Jun 2015 20:06:55 +0800
Subject: [PATCH] arm: crypto: picoxcell: Update to the current clk API
In-Reply-To: <1434722151-4309-1-git-send-email-michael@smart-africa.com>
References: <1434722151-4309-1-git-send-email-michael@smart-africa.com>
Message-ID: <20150621120655.GA30479@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 19, 2015 at 03:55:51PM +0200, Michael van der Westhuizen wrote:
> The picoXcell hardware crypto accelerator driver was using an
> older version of the clk framework, and not (un)preparing the
> clock before enabling/disabling it.  This change uses the handy
> clk_prepare_enable function to interact with the current clk
> framework correctly.
> 
> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
