From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Feb 2012 07:15:45 -0800
Subject: [PATCH] arm/imx6: Rename DEBUG_IMX6Q_UART to UART4
In-Reply-To: <1328530759-6291-1-git-send-email-dirk.behme@de.bosch.com>
References: <1328530759-6291-1-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120211151543.GA2463@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2012 at 01:19:19PM +0100, Dirk Behme wrote:
> Different boards may use differenct UART ports for debugging.
> To be able to add different debug UART configurations (e.g. UART2),
> rename the existing general DEBUG_IMX6Q_UART to DEBUG_IMX6Q_UART4.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/Kconfig.debug                       |    6 +++---
>  arch/arm/mach-imx/lluart.c                   |    2 +-
>  arch/arm/plat-mxc/include/mach/debug-macro.S |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Regards,
Shawn
