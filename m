From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 22 Oct 2012 19:30:28 +0200
Subject: [PATCH 3/5] arm: mvebu: Added IPI support via doorbells
In-Reply-To: <1350925368-24243-4-git-send-email-gregory.clement@free-electrons.com>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
 <1350925368-24243-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121022173028.GM21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 07:02:45PM +0200, Gregory CLEMENT wrote:
> From: Yehuda Yitschak <yehuday@marvell.com>
> 
> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
>  arch/arm/mach-mvebu/armada-370-xp.h     |   10 ++++
>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   92 +++++++++++++++++++++++++++++--
>  3 files changed, 97 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index f521ed8..531619f 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -24,7 +24,7 @@
>  
>  	mpic: interrupt-controller at d0020000 {
>  	      reg = <0xd0020a00 0x1d0>,
> -		    <0xd0021870 0x58>;
> +		    <0xd0021070 0x58>;
>  	};

Hi Gregory

Is this a bug fix needed for 3.7?

   Andrew
