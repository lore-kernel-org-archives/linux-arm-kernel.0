From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 Jun 2014 20:38:21 +0800
Subject: [PATCH] ARM: i.MX: Remove Freescale i.MX27 IP Camera board support
In-Reply-To: <1403112399-19868-1-git-send-email-shc_work@mail.ru>
References: <1403112399-19868-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140620123820.GJ28225@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 09:26:39PM +0400, Alexander Shiyan wrote:
> The board has no insufficient support to be fully functional and seems
> has no users. This patch removes support for this board. However, the
> support may be added in the future by using the devicetree.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/Kconfig           |  9 -----
>  arch/arm/mach-imx/Makefile          |  1 -
>  arch/arm/mach-imx/mach-imx27ipcam.c | 77 -------------------------------------
>  3 files changed, 87 deletions(-)
>  delete mode 100644 arch/arm/mach-imx/mach-imx27ipcam.c

Applied, and dropped the board support from imx_v4_v5_defconfig as well.

Shawn
