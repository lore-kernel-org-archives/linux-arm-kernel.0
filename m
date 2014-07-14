From: broonie@kernel.org (Mark Brown)
Date: Mon, 14 Jul 2014 19:54:01 +0100
Subject: [PATCH 4/4] ASoC: samsung: remove unused DMA data
In-Reply-To: <1405086308-1461192-7-git-send-email-arnd@arndb.de>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <1405086308-1461192-7-git-send-email-arnd@arndb.de>
Message-ID: <20140714185401.GD6800@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 03:45:08PM +0200, Arnd Bergmann wrote:
> The s3c_dma_client structures and the 'ch' and 'ops' members in
> s3c_dma_params were only used by the legacy DMA driver and serve
> no function any more. This removes any reference to them.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/1d2de040/attachment.sig>
