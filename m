From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 25 Jan 2017 07:44:25 +0100
Subject: [1/6] apalis-tk1: remove spurious new lines
In-Reply-To: <1479773647-14726-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1479773647-14726-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20170125064425.GA12626@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 01:14:02AM +0100, Marcel Ziswiler wrote:
> Remove some spurious new lines.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---

For some reason I can't find any trace of this series in my inbox. It's
not even been classified as spam, it's just not there. So I had to pull
this from patchwork in order to reply.

>  arch/arm/boot/dts/tegra124-apalis-eval.dts |  1 -
>  arch/arm/boot/dts/tegra124-apalis.dtsi     | 12 ------------
>  2 files changed, 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> index 653044a..2b5a0f3 100644
> --- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
> +++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
> @@ -232,7 +232,6 @@
>  
>  	backlight: backlight {
>  		compatible = "pwm-backlight";
> -
>  		/* BKL1_PWM */
>  		pwms = <&pwm 3 5000000>;
>  		brightness-levels = <255 231 223 207 191 159 127 0>;

These newlines were introduced to separate standard properties from the
not so standard properties for readability, I'd prefer to keep them.

Same for the ones below.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/aba14db2/attachment.sig>
