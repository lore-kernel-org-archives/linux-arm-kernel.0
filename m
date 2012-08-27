From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 09:37:12 -0700
Subject: [PATCH] mxs/spi: Restart the block after unsuccessful transfer
In-Reply-To: <1345775658-9739-1-git-send-email-marex@denx.de>
References: <1345775658-9739-1-git-send-email-marex@denx.de>
Message-ID: <20120827163711.GD4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 04:34:18AM +0200, Marek Vasut wrote:
> Restart the SSP block in case the SSP transfer failed in any way.
> The block hung in some cases otherwise.

Applied, thanks.
