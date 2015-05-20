From: tytso@mit.edu (Theodore Ts'o)
Date: Wed, 20 May 2015 10:59:01 -0400
Subject: [PATCH] crypto: allow to assign gfp_t for __crypto_alloc_tfm
In-Reply-To: <20150520072118.GN8928@secunet.com>
References: <20150519054945.GA28060@gondor.apana.org.au>
 <20150519062430.GA39588@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519063211.GA28347@gondor.apana.org.au>
 <20150519065812.GA40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519065929.GA28610@gondor.apana.org.au>
 <20150519071317.GB40012@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20150519071521.GA28862@gondor.apana.org.au>
 <20150519141430.GD20421@thunk.org>
 <20150519142755.GB32663@gondor.apana.org.au>
 <20150520072118.GN8928@secunet.com>
Message-ID: <20150520145901.GI2871@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 09:21:20AM +0200, Steffen Klassert wrote:
> The current pcrypt version is used just for IPsec because it supports
> only AEAD type algorithms and does not support request backlog. But
> I have patches to support ablkcipher algorithms and request backlog.
> I could provide them if there is interest in it.

I don't know the crypto layer well enough, and I certainly don't know
how to deal with things like ARM CPU's with "big-little" architectures
to understand what we might need to do to power optimize things for
mobile handsets.  But if someone has time to look at this, that would
be great.

					- Ted
