From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 15:03:03 -0800
Subject: [RFC PATCH 4/9] clk: sunxi-ng: support R40 SoC
In-Reply-To: <20170217173722.6477-5-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
 <20170217173722.6477-5-icenowy@aosc.xyz>
Message-ID: <20170221230303.af5d5zh7smhgcwal@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 18, 2017 at 01:37:17AM +0800, Icenowy Zheng wrote:
> Allwinner R40 SoC have a clock controller module in the style of the
> SoCs beyond sun6i, however, it's more rich and complex.
> 
> Add support for it.
> 
> As the user manual is still not available, this driver is made with
> knowledge from clk-sun8iw11.c in the BSP kernel source.

Missing SoB.

Why are some patches tagged as RFC and some don't?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/b1e5df21/attachment.sig>
