From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 9 Dec 2013 16:40:35 -0500
Subject: [PATCH] Partially revert "mtd: nand: pxa3xx: Introduce
 'marvell,armada370-nand' compatible string"
In-Reply-To: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1386624986-404-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131209214035.GP10053@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 06:36:26PM -0300, Ezequiel Garcia wrote:
> This reverts c0f3b8643a6fa2461d70760ec49d21d2b031d611.
> 
> The "armada370-nand" compatible support is not complete, and it was mistake
> to add it. Revert it and pospone the support until the infrastructure is
> in place.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
