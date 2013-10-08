From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 12:19:09 -0400
Subject: [PATCH 1/4] ARM: kirkwood: Remove unneeded MBus initialization
In-Reply-To: <1380575010-8573-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131008161909.GK5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 06:03:27PM -0300, Ezequiel Garcia wrote:
> Since the MBus is initialized from the DT, it's not necessary to
> call the legacy initialization.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/mach-kirkwood/board-dt.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to mvebu/soc

thx,

Jason.
