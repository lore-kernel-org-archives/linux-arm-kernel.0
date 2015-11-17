From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 17 Nov 2015 22:27:42 +0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <20151117142603.GA1669@Red>
References: <1447420229-17911-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151117140938.GH9546@gondor.apana.org.au>
 <20151117142603.GA1669@Red>
Message-ID: <20151117142742.GA10019@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 03:26:03PM +0100, LABBE Corentin wrote:
>
> I have lots of user reporting that they cannot use the device since it wont load.
> For me it need to go stable since it respect all "stable rules", simple, tested, minimal, and fix a real bug that bother people.

Well it will hit stable eventually.  I just don't feel comfortable
with sending it in straight away.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
