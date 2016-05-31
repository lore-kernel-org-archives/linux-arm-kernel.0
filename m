From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 31 May 2016 18:19:34 +0800
Subject: [PATCH v2 0/4] hw rng support for NSP SoC
In-Reply-To: <1464343841-29504-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1464343841-29504-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <20160531101934.GM15376@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 27, 2016 at 06:10:37AM -0400, Yendapally Reddy Dhananjaya Reddy wrote:
> This patchset contains the hw random number generator support for the
> Broadcom's NSP SoC. The block is similar to the block available in
> bcm2835 with different default interrupt mask value. Due to lack of
> documentation, I cannot confirm the interrupt mask register details
> in bcm2835. In an effort to not break the existing functionality of
> bcm2835, I used a different compatible string to mask the interrupt
> for NSP SoC. Please let me know. Also supported providing requested
> number of random numbers instead of static size of four bytes.
> 
> The first patch contains the documentation changes and the second patch
> contains the support for rng available in NSP SoC. The third patch
> contains the device tree changes for NSP SoC. The fourth patch contains
> the support for reading requested number of random numbers.
> 
> This patch set has been tested on NSP bcm958625HR board.
> This patch set is based on v4.6.0-rc1 and is available from github
> repo: https://github.com/Broadcom/cygnus-linux.git
> branch: nsp-rng-v2
> 
> Changes since v1

All applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
