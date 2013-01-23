From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 07:34:16 -0500
Subject: [PATCH v2] Dove: activate GPIO interrupts in DT
In-Reply-To: <20130123093816.5cb73df1@armhf>
References: <20130123093816.5cb73df1@armhf>
Message-ID: <20130123123416.GG1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 09:38:16AM +0100, Jean-Francois Moine wrote:
> In a DT, the interrupts of an interrupt-controller are not usable when
> #interrupt-cells is missing.
> 
> This patch activates the interrupts of the GPIOs 0 and 1 for the Marvell
> Dove SoC.
> 
> Signed-off-by: Jean-Fran?ois Moine <moinejf@free.fr>
> ---
> v2
> - gpio-mvebu asks for 2 cells
> ---
>  arch/arm/boot/dts/dove.dtsi |    2 ++
>  1 file changed, 2 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
