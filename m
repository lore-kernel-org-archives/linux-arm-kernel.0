From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Jun 2017 16:51:41 +0200
Subject: [PATCH v2] arm64: allwinner: a64: Add initial NanoPi A64 support
In-Reply-To: <1497012052-14027-2-git-send-email-jteki@openedev.com>
References: <1497012052-14027-1-git-send-email-jteki@openedev.com>
 <1497012052-14027-2-git-send-email-jteki@openedev.com>
Message-ID: <20170609145141.aknbsis25vmy3rj6@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jagan,

On Fri, Jun 09, 2017 at 12:40:52PM +0000, Jagan Teki wrote:
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +	status = "okay";
> +};
> +
> +&i2c1_pins {
> +	bias-pull-up;
> +};

What is connected on that bus?

> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status = "okay";
> +};

And on that UART?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/625c79ba/attachment.sig>
