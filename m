From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 12 Dec 2013 15:07:15 -0800
Subject: [PATCH] Partially revert "mtd: nand: pxa3xx: Introduce
 'marvell,armada370-nand' compatible string"
In-Reply-To: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131212230715.GX27149@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 06:36:26PM -0300, Ezequiel Garcia wrote:
> This reverts c0f3b8643a6fa2461d70760ec49d21d2b031d611.

Modified to say "partially reverts".

> 
> The "armada370-nand" compatible support is not complete, and it was mistake
> to add it. Revert it and pospone the support until the infrastructure is
> in place.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Note this won't apply to v3.12 as it is, although fixing it should be easy.

Pushed this patch to linux-mtd.git, noting -stable for 3.12+.

Ezequiel,

Please double-check linux-mtd.git to ensure it fits your liking.

Brian
