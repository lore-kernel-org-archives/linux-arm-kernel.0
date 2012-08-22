From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:12:05 +0100
Subject: [PATCH v3 3/9] ARM: OMAP: board-am3517evm: Configure McBSP1
 CLKR/FSR signal source
In-Reply-To: <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-4-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191205.GJ7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:02PM +0300, Peter Ujfalusi wrote:
> am3517evm board uses McBSP1 for audio with 4pin configuration.
> The CLKR/FSR signals need to be connected to CLKX/FSX pin of the SoC in
> this case.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/5aa9eeb8/attachment.sig>
