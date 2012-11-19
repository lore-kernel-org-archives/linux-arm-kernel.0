From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Nov 2012 16:17:38 +0100
Subject: [PATCH 0/1 V2] ARM: kirkwood: Convert the mplcec4 board to pinctrl
In-Reply-To: <cover.1353336757.git.s.peter@mpl.ch>
References: <cover.1353336757.git.s.peter@mpl.ch>
Message-ID: <20121119151738.GK10259@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 04:00:01PM +0100, Stefan Peter wrote:
> This patch converts the mplcec4 board to using the pinctrl patches.
> 
> Changes from V1
> * moved sdio pinctrl definitions from mplcec4.dts to kirkwood-6281.dtsi for 
>   usage by other boards
> * fixed a typo in the sdio pinctrl definitions (/s/mmp13/mpp13/)
> 
> Stefan Peter (1):
>   Convert mplcec4 board to pinctrl
> 
>  arch/arm/boot/dts/kirkwood-6281.dtsi   |    7 +++-
>  arch/arm/boot/dts/kirkwood-mplcec4.dts |   59 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/board-mplcec4.c |   35 -------------------
>  3 files changed, 65 insertions(+), 36 deletions(-)

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrewy
