From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 14 Jan 2015 17:38:56 +0100
Subject: [PATCH v3 06/13] ARM: dts: sun9i: Add mmc config clock nodes
In-Reply-To: <1421113055-17867-7-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
 <1421113055-17867-7-git-send-email-wens@csie.org>
Message-ID: <20150114163856.GA4891@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 09:37:28AM +0800, Chen-Yu Tsai wrote:
> Add the device tree nodes for the mmc config clock nodes.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index 9d0a66c14caf..9b3b71c6f29b 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -333,6 +333,19 @@
>  		 */
>  		ranges = <0 0 0 0x20000000>;
>  
> +		mmc_config_clk: clk at 01c13000 {

The node names and labels are not really clocks. What about:
    	       mmc_config: mmc_config at ..... ?


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150114/b325053c/attachment.sig>
