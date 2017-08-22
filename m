From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 22 Aug 2017 15:58:44 +0800
Subject: [PATCH] crypto: rockchip: Don't dequeue the request when device
 is busy
In-Reply-To: <1502783295-25621-1-git-send-email-wzz@rock-chips.com>
References: <1502783295-25621-1-git-send-email-wzz@rock-chips.com>
Message-ID: <20170822075844.GI6269@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 03:48:15PM +0800, zain wang wrote:
> The device can only process one request at a time. So if multiple
> requests came at the same time, we can enqueue them first, and
> dequeue them one by one when the device is idle.
> 
> Signed-off-by: zain wang <wzz@rock-chips.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
