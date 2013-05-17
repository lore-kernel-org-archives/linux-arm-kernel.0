From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 17 May 2013 12:55:40 -0400
Subject: [PATCH 1/2] ARM: mvebu: Fix ranges entry on XP GP board
In-Reply-To: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130517165540.GD11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 08:09:57AM -0300, Ezequiel Garcia wrote:
> With the latest device tree reorganization which introduced the
> 'internal-reg' node, now the only region translated is the internal register's.
> This makes the description of the hardware incomplete, for it lacks the
> Device Bus childs address space.
> 
> In order to fix this, it's required to add a 'ranges' entry with a suitable
> address space to map Device Bus childs, on a per-board basis.
> This patch fixes the ranges property on the Armada XP GP board.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> This should be included in v3.10.
> 
>  arch/arm/boot/dts/armada-xp-gp.dts | 3 +++
>  1 file changed, 3 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
