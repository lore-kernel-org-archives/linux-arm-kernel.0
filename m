From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 20 Oct 2012 19:34:51 +0000 (UTC)
Subject: [PATCH 0/7] crypto: omap-sham updates
In-Reply-To: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1210201930440.27264@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Oct 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> This series updates the crypto omap-sham driver and supporting
> infrastructure.

Looks pretty good; this will make it easier for us to migrate the 
omap_hwmod code to a LDM bus.  Will reply to the original patches with a 
few comments and questions.

One general comment - for us to merge these through the OMAP tree, we'll 
need acks from the hardware crypto folks.  AFAIK they are:

CRYPTO API
M:      Herbert Xu <herbert@gondor.apana.org.au>
M:      "David S. Miller" <davem@davemloft.net>
L:      linux-crypto at vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
S:      Maintained
F:      Documentation/crypto/
F:      arch/*/crypto/
F:      crypto/
F:      drivers/crypto/
F:      include/crypto/

So it would be helpful if you could send those patches along to those 
people and lists too, and ask them for acks.


- Paul
