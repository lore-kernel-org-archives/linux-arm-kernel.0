From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 21:38:13 +0100
Subject: [PATCH v3 3/6] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170119175448.11445-3-icenowy@aosc.xyz>
References: <20170119175448.11445-1-icenowy@aosc.xyz>
 <20170119175448.11445-3-icenowy@aosc.xyz>
Message-ID: <20170120203813.buj4d4wciuwnd2ey@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 01:54:45AM +0800, Icenowy Zheng wrote:
> V3s has a similar but cut-down CCU to H3. Some muxes, especially clocks
> about CSI, are different, which makes it to need a new CCU driver.
> 
> Add such a new driver for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---

Having a changelog somewhere would help. Why did you drop your cover
letter?

> +static const char * const mbus_parents[] = { "osc24M", "pll-periph0-2x", "pll-ddr" };

This is more that 80 characters and triggers a warning in
checkpatch...

Anyway, fixed and applied.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170120/3819e135/attachment.sig>
