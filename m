From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 May 2014 16:17:09 +0100
Subject: [PATCH 2/4] spi: qup: Correct selection of FIFO/Block mode
In-Reply-To: <1400016884-9568-3-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-3-git-send-email-agross@codeaurora.org>
Message-ID: <20140514151709.GF12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 04:34:42PM -0500, Andy Gross wrote:
> This patch fixes the calculation for determining whether to use FIFO or BLOCK
> mode.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/ea7dfec3/attachment.sig>
