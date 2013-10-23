From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Oct 2013 10:05:30 +0100
Subject: [PATCH] spi: spi-imx: only enable the clocks when we start to
 transfer a message
In-Reply-To: <1382517110-29913-1-git-send-email-b32955@freescale.com>
References: <1382517110-29913-1-git-send-email-b32955@freescale.com>
Message-ID: <20131023090530.GH9388@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 04:31:50PM +0800, Huang Shijie wrote:
> Current code keeps the clocks enabled all the time, it wastes the power
> when there is no operaiton on the spi controller.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/f045e326/attachment.sig>
