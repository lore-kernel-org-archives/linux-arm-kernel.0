From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 31 Jul 2018 16:16:22 +0200
Subject: [PATCH v2] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
In-Reply-To: <20180730115223.14161-1-diego.rondini@kynetics.com>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
 <20180730115223.14161-1-diego.rondini@kynetics.com>
Message-ID: <20180731141622.d3hvpfc5h74pwtgm@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Jul 30, 2018 at 01:52:23PM +0200, Diego Rondini wrote:
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status = "okay";
> +};

Like I said in the mail from a minute ago, we either want the serdev
node, or no BT node at all and leave it for later.

The rest looks fine, thanks!
maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180731/a4832b4f/attachment.sig>
