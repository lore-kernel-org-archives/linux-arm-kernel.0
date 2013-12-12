From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 12 Dec 2013 09:11:42 -0500
Subject: [PATCH] ARM: mvebu: config: Enable NAND support
In-Reply-To: <1386800920-7096-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386800920-7096-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1386800920-7096-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131212141142.GQ10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 07:28:40PM -0300, Ezequiel Garcia wrote:
> Enable the pxa3xx-nand driver, which now supports the NAND controller
> in Armada 370/XP SoC.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/defconfig

thx,

Jason.
