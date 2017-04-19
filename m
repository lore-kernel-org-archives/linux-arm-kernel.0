From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 19 Apr 2017 21:40:13 +0200
Subject: [v5,2/8] mfd: retu: Drop -mfd suffix from I2C device ID name
In-Reply-To: <20170412172800.23035-3-javier@osg.samsung.com>
References: <20170412172800.23035-3-javier@osg.samsung.com>
Message-ID: <20170419194013.op72kqoa4otn2lfy@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 02:27:53PM -0300, Javier Martinez Canillas wrote:
> It's not correct to encode the subsystem in the I2C device name, so
> drop the -mfd suffix. To maintain bisect-ability, change driver and
> platform code / DTS users in the same patch.
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170419/6616a017/attachment.sig>
