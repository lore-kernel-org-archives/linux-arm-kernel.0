From: broonie@kernel.org (Mark Brown)
Date: Fri, 13 Oct 2017 11:17:19 +0100
Subject: [PATCH 1/2] spi: rockchip: Convert to late and early system PM
 callbacks
In-Reply-To: <20171013100116.8271-1-jeffy.chen@rock-chips.com>
References: <20171013100116.8271-1-jeffy.chen@rock-chips.com>
Message-ID: <20171013101719.bophbiz7qb5wi7n2@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 13, 2017 at 06:01:15PM +0800, Jeffy Chen wrote:
> Currently we are suspending the spi master in it's ->suspend callback,
> which is racy as some other drivers may still want to transmit messages
> on the bus(e.g. spi based pwm backlight).

I'm missing patch 2/2.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171013/e0813609/attachment.sig>
