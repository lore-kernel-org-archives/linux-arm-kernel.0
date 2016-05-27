From: broonie@kernel.org (Mark Brown)
Date: Fri, 27 May 2016 21:31:40 +0100
Subject: [PATCH 14/14] ASoC: omap-mcpdm: Add support for pdmclk clock
 handling
In-Reply-To: <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
References: <1463579196-5484-1-git-send-email-peter.ujfalusi@ti.com>
 <1463579196-5484-15-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20160527203140.GD29837@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 04:46:36PM +0300, Peter Ujfalusi wrote:

> +	clk_prepare_enable(mcpdm->pdmclk);

Should really check the return value here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160527/e9a4f037/attachment.sig>
