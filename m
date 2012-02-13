From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 13 Feb 2012 08:33:20 -0800
Subject: [PATCH v5 1/2] mxs-dma : move the mxs dma.h to a more common place
In-Reply-To: <1329110756-14434-2-git-send-email-b32955@freescale.com>
References: <1329110756-14434-1-git-send-email-b32955@freescale.com>
 <1329110756-14434-2-git-send-email-b32955@freescale.com>
Message-ID: <20120213163319.GC3494@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 01:25:55PM +0800, Huang Shijie wrote:
> Move the header to a more common place.
> The mxs dma engine is not only used in mx23/mx28, but also used
> in mx50/mx6q.  It will also be used in the future chips.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120213/ad71b790/attachment.sig>
