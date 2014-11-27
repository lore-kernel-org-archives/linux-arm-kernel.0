From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 10:58:15 +0000
Subject: [PATCH 1/3] ASoC: davinci-evm: Do not include edma headers
In-Reply-To: <1417084891-17990-2-git-send-email-peter.ujfalusi@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <1417084891-17990-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20141127105815.GE7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 12:41:29PM +0200, Peter Ujfalusi wrote:
> The machine driver has no business with the underlying dma.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/288c7845/attachment.sig>
