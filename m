From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 20:13:35 +0100
Subject: [PATCH v3 4/9] ASoC: am3517evm: Do not configure McBSP1 CLKR/FSR
 signal muxing
In-Reply-To: <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
References: <1345124468-8876-1-git-send-email-peter.ujfalusi@ti.com>
 <1345124468-8876-5-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20120822191335.GK7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 04:41:03PM +0300, Peter Ujfalusi wrote:
> The muxing is done at board level, no need to do it in the ASoC machine
> driver.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/e4e237b0/attachment.sig>
