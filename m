From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Dec 2013 11:32:29 +0000
Subject: [PATCH v6 08/17] spi: mpc512x: adjust to OF based clock lookup
In-Reply-To: <1385851897-23475-9-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-9-git-send-email-gsi@denx.de>
Message-ID: <20131202113229.GO27568@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 11:51:28PM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the 'ipg' clock item for register access as well

Acked-by: Mark Brown <broonie@linaro.org.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131202/126b7711/attachment.sig>
