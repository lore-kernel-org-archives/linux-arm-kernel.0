From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Jun 2014 11:13:03 +0100
Subject: [Patch v2 1/3] spi: qup: Remove chip select function
In-Reply-To: <1402601652-24641-2-git-send-email-agross@codeaurora.org>
References: <1402601652-24641-1-git-send-email-agross@codeaurora.org>
 <1402601652-24641-2-git-send-email-agross@codeaurora.org>
Message-ID: <20140621101303.GE5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 02:34:10PM -0500, Andy Gross wrote:
> This patch removes the chip select function.  Chip select should instead be
> supported using GPIOs, defining the DT entry "cs-gpios", and letting the SPI
> core assert/deassert the chip select as it sees fit.

Why?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140621/f9576bcf/attachment.sig>
