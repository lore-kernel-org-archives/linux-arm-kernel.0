From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Sat, 17 Oct 2015 11:01:44 -0300
Subject: [PATCH v3 3/4] mtd: pxa3xx_nand: rework flash detection and
 timing setup
In-Reply-To: <1444893451-16610-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1444893451-16610-1-git-send-email-antoine.tenart@free-electrons.com>
 <1444893451-16610-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20151017140144.GB1578@laptop.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine,

On 15 Oct 09:17 AM, Antoine Tenart wrote:
> Rework the pxa3xx_nand driver to allow using functions exported by the
> nand framework to detect the flash and the timings. Then setup the
> timings using the helpers previously added.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> ---
>  drivers/mtd/nand/pxa3xx_nand.c | 118 +++++++++--------------------------------
>  1 file changed, 25 insertions(+), 93 deletions(-)
> 

This patch is not applying on l2-mtd.git master. Care to rebase it?
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
