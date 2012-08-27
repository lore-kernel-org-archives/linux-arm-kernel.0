From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 27 Aug 2012 09:37:28 -0700
Subject: [PATCH V3] mxs/spi: Fix misuse of init_completion
In-Reply-To: <1345776987-15350-1-git-send-email-marex@denx.de>
References: <1345776987-15350-1-git-send-email-marex@denx.de>
Message-ID: <20120827163727.GE4339@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2012 at 04:56:27AM +0200, Marek Vasut wrote:
> The init_completion() call does reinit not only the variable carrying
> the flag that the completion finished, but also initialized the
> waitqueue associated with the completion. On the contrary, the
> INIT_COMPLETION() call only reinits the flag.

Applied, thanks.
