From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Oct 2017 10:54:29 +0800
Subject: [PATCH 1/4] ARM: dts: imx6ul-pico-hobbit: Fix the 'interrupts'
 property
In-Reply-To: <1508193244-14599-1-git-send-email-festevam@gmail.com>
References: <1508193244-14599-1-git-send-email-festevam@gmail.com>
Message-ID: <20171018025428.GJ18810@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 08:34:01PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> The 'interrupts' property has an extra cell by mistake.
> 
> Fix this, so that the following build warning is gone:
> 
>  DTC     arch/arm/boot/dts/imx6ul-pico-hobbit.dtb
> arch/arm/boot/dts/imx6ul-pico-hobbit.dtb: Warning (interrupts_property): interrupts size is (12), expected multiple of 8 in /soc/aips-bus at 2000000/ethernet at 20b4000/mdio/ethernet-phy at 1
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
