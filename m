From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 04 Feb 2013 15:41:38 +0100
Subject: [PATCHv2 1/2] ARM: dma-mapping: add support for CMA regions
 placed in highmem zone
In-Reply-To: <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
References: <1358350284-6972-2-git-send-email-m.szyprowski@samsung.com>
 <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <xa1td2wgb0pp.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, Feb 04 2013, Marek Szyprowski wrote:
> This patch adds missing pieces to correctly support memory pages served
> from CMA regions placed in high memory zones. Please note that the default
> global CMA area is still put into lowmem and is limited by optional
> architecture specific DMA zone. One can however put device specific CMA
> regions in high memory zone to reduce lowmem usage.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/025f50b8/attachment.sig>
