From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 08:12:11 +0200
Subject: [RFC PATCH 1/5] clk: sunxi: Add a driver for the PLL2 on A31/23/33
In-Reply-To: <20160628101325.2522-1-icenowy@aosc.xyz>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
Message-ID: <20160705061211.GA7643@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 28, 2016 at 06:13:21PM +0800, Icenowy Zheng wrote:
> This is based on the PLL2 driver for A10/20.

Thanks for this patch.

However, as you might have seen, we're switching to a new clock code
base, so it would be great if you could use that instead.

http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/440077.html

While we declared all the clocks for the H3, nothing really mandates
that for the existing platforms we don't introduce a few clocks as
they are needed. That will probably even smoothen the transition.

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/01ba6825/attachment.sig>
