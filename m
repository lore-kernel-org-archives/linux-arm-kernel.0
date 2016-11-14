From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 14 Nov 2016 09:55:40 +0100
Subject: [PATCH 2/3] ARM: dts: sunxi: add Allwinner H2+ dtsi
In-Reply-To: <20161111164654.15273-2-icenowy@aosc.xyz>
References: <20161111164654.15273-1-icenowy@aosc.xyz>
 <20161111164654.15273-2-icenowy@aosc.xyz>
Message-ID: <20161114085540.x2hp5k7eyjv6l2dd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 12, 2016 at 12:46:53AM +0800, Icenowy Zheng wrote:
> Allwinner H2+ is a SoC so similar with H3 that H3 drivers and memory map
> is known to work well on H2+, with both BSP kernel/firmware or the
> mainline ones.
> 
> So add a dtsi file which only include the H3 dtsi only, so we can add
> H2+-specified nodes in the dtsi file when we find any software
> difference between H2+ and H3.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

I don't think we need that patch at all. You can do it just like we
did for the R8 and R16, just include the H3 DTSI in your board. We'll
create it if we need it at some point.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161114/1a597c68/attachment-0001.sig>
