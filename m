From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 15 Oct 2018 00:35:34 +0200
Subject: [PATCH 2/2] mmc: uniphier-sd: avoid using broken DMA RX channel
In-Reply-To: <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
References: <1539356258-12374-1-git-send-email-yamada.masahiro@socionext.com>
 <1539356258-12374-3-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20181014223534.GG3260@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 11:57:38PM +0900, Masahiro Yamada wrote:
> host->chan_rx is NULL when UNIPHIER_SD_CAP_BROKEN_DMA_RX quirk flag
> is set. In this case, it should not set up DMA.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181015/73412a7d/attachment-0001.sig>
