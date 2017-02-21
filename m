From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Feb 2017 15:05:40 -0800
Subject: [RFC PATCH 9/9] ARM: dts: sun8i: enable USB host for Banana Pi
 M2 Ultra
In-Reply-To: <20170217173722.6477-10-icenowy@aosc.xyz>
References: <20170217173722.6477-1-icenowy@aosc.xyz>
 <20170217173722.6477-10-icenowy@aosc.xyz>
Message-ID: <20170221230540.fqvzismg2p4qdmnh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 18, 2017 at 01:37:22AM +0800, Icenowy Zheng wrote:
> Banana Pi M2 Ultra board features two USB host ports, connected to the
> two USB host ports on the SoC.
> 
> Add support for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Same comment than for the DTSI. This should be merged with the rest of
the DTS' patch.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170221/a2a4a32e/attachment.sig>
