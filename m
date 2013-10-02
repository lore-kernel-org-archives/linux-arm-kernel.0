From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Oct 2013 13:43:32 -0400
Subject: [PATCH v2 1/4] clk: mvebu: Add Core Divider clock
In-Reply-To: <1380224130-11868-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380224130-11868-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380224130-11868-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131002174332.GQ31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 26, 2013 at 04:35:27PM -0300, Ezequiel Garcia wrote:
> This commit introduces a new group of clocks present in Armada 370/XP
> SoCs (called "Core Divider" clocks) and add a provider for them.
> The only clock supported for now is the NAND clock (ndclk), but the
> infrastructure to add the rest is already set.
> 
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clk/mvebu/Kconfig       |   5 +
>  drivers/clk/mvebu/Makefile      |   1 +
>  drivers/clk/mvebu/clk-corediv.c | 223 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 229 insertions(+)
>  create mode 100644 drivers/clk/mvebu/clk-corediv.c

Acked-by: Jason Cooper <jason@lakedaemon.net>

Please let me know once this gets pulled into the clock tree, and I'll
pull in the remaining patches.

thx,

Jason.
