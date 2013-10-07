From: broonie@kernel.org (Mark Brown)
Date: Mon, 7 Oct 2013 11:17:55 +0100
Subject: [PATCH 1/2] ASoC: fsl: imx-ssi: fix probe on imx31
In-Reply-To: <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
References: <1380630971-11431-1-git-send-email-philippe.retornaz@epfl.ch>
 <1380630971-11431-2-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20131007101755.GC21581@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 02:36:10PM +0200, Philippe R?tornaz wrote:
> On imx31 with mc13783 codec the FIQ is not necessary and not enabled
> as DMA transfer is available.
> Change the probe() function to fail only if both FIQ and DMA are not
> available.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131007/3702054a/attachment.sig>
