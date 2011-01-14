From: mpm@selenic.com (Matt Mackall)
Date: Fri, 14 Jan 2011 12:48:15 -0600
Subject: [PATCHv2] hwrng: add support for picoxcell TRNG
In-Reply-To: <1295030661-16364-1-git-send-email-jamie@jamieiles.com>
References: <20110114181609.GN2822@pulham.picochip.com>
	<1295030661-16364-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1295030895.30392.21.camel@calx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-01-14 at 18:44 +0000, Jamie Iles wrote:
> This driver adds support for the True Random Number Generator in
> the Picochip PC3X3 and later devices.
> 
> v2: fix indentation and cleanup read function to remove single use
> variables and to take advantage of the rng buffer being aligned.
> 
> Cc: Matt Mackall <mpm@selenic.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
