From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 13 May 2013 16:08:10 -0400
Subject: [PATCH] ARM: mvebu: Add support for USB storage class in
 mvebu_defconfig
In-Reply-To: <1366228294-24437-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1366228294-24437-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130513200810.GZ31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 04:51:34PM -0300, Ezequiel Garcia wrote:
> Some boards can have built-in USB storage class controllers so
> it's better to have this option included by default.
> 
> Currently this option is needed to support built-in USB MMC controller
> found in Globalscale Mirabox board.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> This is not important and can be delayed for v3.11 if it's already
> too late for v3.10. The change is harmless in any case.
> 
>  arch/arm/configs/mvebu_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig

thx,

Jason.
