From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 23 Sep 2013 20:03:55 +0300
Subject: [PATCH V3: Add Smp support for Allwinner A20. 2/3] Add cpuconfig
 nodes in dts for smp configure.
In-Reply-To: <1379852488-32147-3-git-send-email-cinifr@gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-3-git-send-email-cinifr@gmail.com>
Message-ID: <20130923170355.GP2779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fan,

On Sun, Sep 22, 2013 at 08:21:27PM +0800, Fan Rong wrote:
> Signed-off-by: Fan Rong <cinifr@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 999ff45..f745e0b 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -20,13 +20,13 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		cpu0: cpu at 0  {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			reg = <0>;
>  		};
>  
> -		cpu at 1 {
> +		cpu1: cpu at 1 {

You still haven't replied on why you need these two changes.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/5aa20a34/attachment.sig>
