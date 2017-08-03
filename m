From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 3 Aug 2017 14:26:13 +0800
Subject: [RESEND PATCH 0/2] crypto/rockchip: fix some issue which causes
 crypto failed
In-Reply-To: <1500859394-1799-1-git-send-email-wzz@rock-chips.com>
References: <1500859394-1799-1-git-send-email-wzz@rock-chips.com>
Message-ID: <20170803062613.GN12039@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 09:23:12AM +0800, zain wang wrote:
> These patches fix some bugs on rockchip's crypto which would cause crypto failed.
> 
> zain wang (2):
>   crypto: rockchip - move the crypto completion from interrupt context
>   crypto: rockchip - return the err code when unable dequeue the crypto
>     request

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
