From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 27 Jun 2012 14:48:43 +0800
Subject: [PATCH] ARM: mxc-rnga: fix data_present API
In-Reply-To: <449445897.2590473.1339604134205.JavaMail.root@advansee.com>
References: <20120613063650.GB32436@pengutronix.de>
 <449445897.2590473.1339604134205.JavaMail.root@advansee.com>
Message-ID: <20120627064843.GA22920@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 06:15:34PM +0200, Beno?t Th?baudeau wrote:
>
> [PATCH] ARM: mxc-rnga: fix data_present API
> 
> Commit 45001e9, which added support for RNGA, ignored the previous commit
> 984e976, which changed the data_present API.
> 
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Alan Carvalho de Assis <acassis@gmail.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
