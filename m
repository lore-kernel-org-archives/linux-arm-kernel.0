From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 24 Apr 2017 11:06:33 +0200
Subject: [PATCH v5 09/11] ARM: dts: sun8i: add DE2 nodes for V3s SoC
In-Reply-To: <20170423103754.50012-10-icenowy@aosc.io>
References: <20170423103754.50012-1-icenowy@aosc.io>
 <20170423103754.50012-10-icenowy@aosc.io>
Message-ID: <20170424090633.7pn46u63qzeoxjrl@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 23, 2017 at 06:37:52PM +0800, Icenowy Zheng wrote:
> +				tcon0_out: port at 1 {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <1>;
> +				};
> +			};
> +		};
> +
> +

There's one too many newline here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170424/64cab28a/attachment.sig>
