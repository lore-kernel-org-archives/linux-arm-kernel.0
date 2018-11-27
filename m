From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Nov 2018 11:43:24 +0000
Subject: [PATCH v2 0/1] add SPI driver support for mt7629
In-Reply-To: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
References: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20181127114324.GA3206@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 10:29:49AM +0800, Leilk Liu wrote:
> From cf719ac350c36cb58e2013b58f73ad04f6981384 Mon Sep 17 00:00:00 2001
> From: Leilk Liu <leilk.liu@mediatek.com>
> Date: Tue, 27 Nov 2018 10:18:30 +0800
> Subject: [PATCH v2 0/1] add SPI driver support for mt7629
> 
> v2:
> remove "mediatek,mt7629-spi" compatible according Matthias's advice.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that 
any important information is recorded in the changelog rather than being
lost. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181127/506e39ae/attachment.sig>
