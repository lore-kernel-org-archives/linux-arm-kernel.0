From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Aug 2015 18:47:21 +0100
Subject: [PATCH v3 2/4] spi: mediatek: replace int with u32, delete TAB
 and define MTK_SPI_PAUSE_INT_STATUS marco
In-Reply-To: <1440387918-22191-3-git-send-email-leilk.liu@mediatek.com>
References: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
 <1440387918-22191-3-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20150825174721.GH12878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 11:45:16AM +0800, Leilk Liu wrote:

> this patch replaces int with u32, deletes TAB, and defines
> MTK_SPI_PAUSE_INT_STATUS marco.

You've listed three changes in one patch and they're not obviously
interrelated.  As has been said before one change per patch please :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/7b786396/attachment.sig>
