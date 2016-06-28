From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jun 2016 13:46:40 +0200
Subject: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
In-Reply-To: <20160628101325.2522-3-icenowy@aosc.xyz>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
Message-ID: <20160628114640.GE5550@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for working on this.

On Tue, Jun 28, 2016 at 06:13:23PM +0800, Icenowy Zheng wrote:
> This patch adds support for the sun8iw3 thermal sensor on
> Allwinner A23/33 SoCs.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

The IP is awfully similar to the A31's, which already has a driver
(drivers/input/touchscreen/sun4i-ts.c).

There's no reason to add a new one here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/7c01e9c6/attachment.sig>
