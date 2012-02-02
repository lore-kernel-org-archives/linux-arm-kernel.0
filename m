From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Feb 2012 21:56:29 -0700
Subject: [PATCH] arm/dts: OMAP3: Add omap3evm and am335xevm support
In-Reply-To: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
References: <1328077620-22411-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20120202045629.GJ15343@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2012 at 11:57:00AM +0530, Vaibhav Hiremath wrote:
> TI's OMAP3EVM and AM335xEVM are software development boards
> available for OMAP35x(AM/DM37x) and AM335x devices respectively;
> and these devices are considered under omap3 family.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>

Applied, thanks.

g.

> ---
>  .../devicetree/bindings/arm/omap/omap.txt          |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index dbdab40..ce78498 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -41,3 +41,9 @@ Boards:
> 
>  - OMAP4 PandaBoard : Low cost community board
>    compatible = "ti,omap4-panda", "ti,omap4430"
> +
> +- OMAP3 EVM : Software Developement Board for OMAP35x, AM/DM37x
> +  compatible = "ti,omap3-evm", "ti,omap3"
> +
> +- AM335X EVM : Software Developement Board for AM335x
> +  compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3"
> --
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
