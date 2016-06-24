From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 24 Jun 2016 21:31:22 +0800
Subject: [PATCH 2/3] hw_random: bcm2835: Add support for Broadcom BCM5301x
In-Reply-To: <1466641623-3491-3-git-send-email-f.fainelli@gmail.com>
References: <1466641623-3491-1-git-send-email-f.fainelli@gmail.com>
 <1466641623-3491-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <20160624133122.GC21111@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 05:27:02PM -0700, Florian Fainelli wrote:
> The Broadcom BCM5301x SoCs (Northstar) utilize the same random number
> generator peripheral as Northstar Plus and BCM2835, but just like the
> NSP SoC, we need to enable the interrupt.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
