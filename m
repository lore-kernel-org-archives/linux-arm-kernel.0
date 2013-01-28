From: olof@lixom.net (Olof Johansson)
Date: Sun, 27 Jan 2013 23:13:12 -0800
Subject: [PATCHv1 for soc 2/5] arm: socfpga: Add clock entries to
 socfpga.dtsi
In-Reply-To: <1359075633-13502-3-git-send-email-dinguyen@altera.com>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-3-git-send-email-dinguyen@altera.com>
Message-ID: <20130128071312.GI25723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 24, 2013 at 07:00:30PM -0600, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Pavel Machek <pavel@denx.de>
> ---
>  arch/arm/boot/dts/socfpga.dtsi |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 936d230..688729f 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -78,6 +78,43 @@
>  			};
>  		};
>  
> +		clkmgr at ffd04000 {
> +			compatible = "altr, clk-mgr";


No space after "altr,". Also, this should have documented bindings under
Documentation/device-tree/bindings (and those should be cc:d to the appropriate
maintainers).


-Olof
