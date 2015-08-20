From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 20 Aug 2015 13:29:03 +0800
Subject: un4i-ss-cipher.c warning
In-Reply-To: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
References: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
Message-ID: <20150820052903.GA26031@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 04:35:36PM +0200, Michal Suchanek wrote:
> Hello,
> 
> when building a kernel with sunxi crypto driver as merged into the
> sinxi-wip branch I get a compiler warning.
> 
> I am not sure this is the latest version of the driver. It does not
> seem to be in mainline yet.

The warning appears to be spurious as the code always ends up
initialising todo before using it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
