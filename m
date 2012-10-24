From: simon@horms.net (Simon Horman)
Date: Wed, 24 Oct 2012 17:08:38 +0900
Subject: [PATCH] ARM: mach-shmobile: Use DT_MACHINE for mackerel
In-Reply-To: <1351057680-4755-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1351057680-4755-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <20121024080838.GB28496@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 02:48:00PM +0900, Nobuhiro Iwamatsu wrote:
> Use DT_MACHINE_START() on the sh7372 based mackerel board.
> 
> Also include a tiny DTS file to describe the board and update the
> Kconfig dependencies to select CONFIG_USE_OF.

Thanks, I have applied this to the boards branch of
my renesas tree.
