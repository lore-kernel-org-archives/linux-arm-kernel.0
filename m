From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 16:17:12 +0100
Subject: [PATCH 6/6] spi: st-ssc4: Remove 'no clocking' hack
In-Reply-To: <20160607111930.10375-7-lee.jones@linaro.org>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160607111930.10375-7-lee.jones@linaro.org>
Message-ID: <20160607151712.GA7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 12:19:30PM +0100, Lee Jones wrote:
> Due to the newly upstreamed 'critical clocks' API we can now
> safely handle clocking in the SPI and I2C drivers without fear
> of catastrophically crippling the running platform.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/12e6ab7b/attachment.sig>
