From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 21 Mar 2013 17:53:54 +0800
Subject: [PATCH v3 2/2] crypto: sahara: Add driver for SAHARA2 accelerator.
In-Reply-To: <1362137873-8827-3-git-send-email-javier.martin@vista-silicon.com>
References: <1362137873-8827-1-git-send-email-javier.martin@vista-silicon.com>
 <1362137873-8827-3-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <20130321095354.GA26931@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 01, 2013 at 12:37:53PM +0100, Javier Martin wrote:
> SAHARA2 HW module is included in the i.MX27 SoC from
> Freescale. It is capable of performing cipher algorithms
> such as AES, 3DES..., hashing and RNG too.
> 
> This driver provides support for AES-CBC and AES-ECB
> by now.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Patch applied to cryptodev.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
