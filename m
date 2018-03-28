From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Mar 2018 10:14:16 +0800
Subject: [PATCH] spi: mediatek: remove redundant MODULE_ALIAS entries
In-Reply-To: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
References: <58fc8553bdc3cbad8d107a905947b7e4d9c12b92.1522054975.git.sean.wang@mediatek.com>
Message-ID: <20180328021416.GK29239@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 06:04:18PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MODULE_ALIAS exports information to allow the module to be auto-loaded at
> boot for the drivers registered using legacy platform registration.
> 
> However, currently the driver is always used by DT-only platform,
> MODULE_ALIAS is redundant and should be removed properly.

There is no meaningful cost to having the alias there, why remove it?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/a8f3f2d4/attachment-0001.sig>
