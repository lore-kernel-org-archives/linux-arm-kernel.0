From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Sep 2015 13:29:05 +0200
Subject: [PATCH 2/4] ARM: dts: sun7i: Add keypad node to Allwinner A20 SoC
In-Reply-To: <1442325957-10102-3-git-send-email-yassinjaffer@gmail.com>
References: <1442325957-10102-1-git-send-email-yassinjaffer@gmail.com>
 <1442325957-10102-3-git-send-email-yassinjaffer@gmail.com>
Message-ID: <20150917112905.GC4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yassin,

On Wed, Sep 16, 2015 at 12:05:55AM +1000, yassinjaffer at gmail.com wrote:
> From: Yassin Jaffer <yassinjaffer@gmail.com>
> 
> Add Keypad controller node definition to the A20 SoC.
> 
> Signed-off-by: Yassin Jaffer <yassinjaffer@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 333604a..35cc8d0 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1198,6 +1198,15 @@
>  			status = "disabled";
>  		};
>  
> +		kp: kp at 01c23000 {

The node name should reflect the class of the device. keypad at 01c23000
would be better for example.

It looks good otherwise.

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150917/5e4505a3/attachment.sig>
