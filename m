From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 7 Sep 2016 21:19:42 +0800
Subject: [PATCH] char: hw_random: bcm2835: handle of_iomap failures in
 bcm2835 driver
In-Reply-To: <1472490616-9597-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1472490616-9597-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <20160907131942.GE17176@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 10:40:16PM +0530, Arvind Yadav wrote:
> Check return value of of_iomap and handle errors correctly.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
