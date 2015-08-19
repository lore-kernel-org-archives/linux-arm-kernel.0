From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Aug 2015 10:26:26 -0700
Subject: [PATCH 3/3] spi: mediatek: fix spi incorrect endian usage
In-Reply-To: <1439955478-2733-4-git-send-email-leilk.liu@mediatek.com>
References: <1439955478-2733-1-git-send-email-leilk.liu@mediatek.com>
 <1439955478-2733-4-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20150819172626.GV10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 11:37:58AM +0800, Leilk Liu wrote:
> TX_ENDIAN/RX_ENDIAN bits define whether to reverse the endian
> order of the data DMA from/to memory. The endian order should
> keep the same with cpu endian.

This doesn't apply, probably because it depends on your stylistic
changes patch - this is an example of the issues I was mentioning with
stylistic changes getting in the waty of fixes :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150819/a89cb2d0/attachment.sig>
