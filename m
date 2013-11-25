From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Nov 2013 17:30:08 +0000
Subject: [PATCH v5 08/17] spi: mpc512x: adjust to OF based clock lookup
In-Reply-To: <1384729577-7336-9-git-send-email-gsi@denx.de>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
 <1384729577-7336-9-git-send-email-gsi@denx.de>
Message-ID: <20131125173008.GQ14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 12:06:08AM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'

Have there been other changes which make this happen?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/e4944b5f/attachment.sig>
