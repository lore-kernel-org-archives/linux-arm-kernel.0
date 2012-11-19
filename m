From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 17:44:54 +0100
Subject: [PATCH] arm: orion5x: convert Netgear WNR854T to device tree
In-Reply-To: <1353342451-27180-1-git-send-email-kaloz@openwrt.org>
References: <1353342451-27180-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20121119174454.67ad1f25@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Imre Kaloz,

On Mon, 19 Nov 2012 17:27:31 +0100, Imre Kaloz wrote:
> This commit converts the Netgear WNR854T to device tree
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/arm/boot/dts/Makefile                    |    3 +-
>  arch/arm/boot/dts/orion5x-netgear-wnr854t.dts |   83 +++++++++++++++++++++++++
>  arch/arm/mach-orion5x/Kconfig                 |    7 +-
>  arch/arm/mach-orion5x/Makefile                |    2 +-
>  arch/arm/mach-orion5x/board-dt.c              |    3 +
>  arch/arm/mach-orion5x/common.h                |    5 ++
>  arch/arm/mach-orion5x/wnr854t-setup.c         |   59 +-----------------
>  7 files changed, 99 insertions(+), 63 deletions(-)
>  create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts

Thanks, looks good to me.

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
