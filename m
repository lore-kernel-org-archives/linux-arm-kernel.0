From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 12:22:06 -0400
Subject: [PATCH 2/4] ARM: kirkwood: Remove unneeded PCIe clock adding
In-Reply-To: <1380575010-8573-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131008162206.GL5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 06:03:28PM -0300, Ezequiel Garcia wrote:
> Since the PCIe devices is properly initialized from the DT, the clocks
> are now referenced in the device tree nodes, and it's not needed
> to have this hack to add them explicitly.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/board-dt.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to mvebu/soc

thx,

Jason.
