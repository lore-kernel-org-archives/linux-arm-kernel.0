From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 12:30:42 -0400
Subject: [PATCH] ARM: mvebu: Add a ranges entry to translate devbus childs
In-Reply-To: <1368458573-18043-1-git-send-email-elezegarcia@gmail.com>
References: <1368458573-18043-1-git-send-email-elezegarcia@gmail.com>
Message-ID: <20130513163042.GQ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 13, 2013 at 12:22:53PM -0300, Ezequiel Garcia wrote:
> From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> With the latest device tree reorganization which introduced the
> 'internal-reg' node, now the only region translated is the internal register's.
> This makes the description of the hardware incomplete, for it lacks the
> Device Bus childs address space.
> 
> In order to fix this, it's required to add a 'ranges' entry with a suitable
> address space to map Device Bus childs, on a per-board basis.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Applies on v3.10-rc1. This is meant for v3.10.
> 
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 3 +++
>  1 file changed, 3 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
