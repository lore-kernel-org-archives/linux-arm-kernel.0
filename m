From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 22 Sep 2015 16:29:44 +0200
Subject: [PATCH 2/5] ARM: dts: sun5i: Add PWM channel 0 pinmux setting
 for A13/A10s
In-Reply-To: <1442752251-20744-3-git-send-email-hdegoede@redhat.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <1442752251-20744-3-git-send-email-hdegoede@redhat.com>
Message-ID: <20150922142944.GD4684@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 20, 2015 at 08:30:48AM -0400, Hans de Goede wrote:
> Add a pinmux setting for the first pwm channel. This is often used for
> backlight dimming on tablets.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index 5e036a4..f0714d3 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -529,6 +529,13 @@
>  				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
>  				allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  			};
> +
> +			pwm0_pins: pwm0 {

Is there a reason why you call this pinset pwm0, while it looks like
there's a single pwm controller?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150922/86ee2f9f/attachment.sig>
