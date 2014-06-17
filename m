From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jun 2014 00:38:00 +0200
Subject: [RFC PATCH 2/4] ARM: tegra: Add Tegra124 EMC support
In-Reply-To: <1402925713-25426-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1402925713-25426-1-git-send-email-tomeu.vizoso@collabora.com>
 <1402925713-25426-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20140617223759.GB25309@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 03:35:11PM +0200, Tomeu Vizoso wrote:
[...]
> +	memory-controller at 7001b000 {
> +		compatible = "nvidia,tegra124-emc";
> +		reg = <0x00 0x7001b000 0x00 0x1000>;

For consistency, perhaps s/0x00/0x0/?

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&tegra_car 57>;

TEGRA124_CLK_EMC?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/a3a8f026/attachment.sig>
