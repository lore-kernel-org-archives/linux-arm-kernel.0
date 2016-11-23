From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Nov 2016 10:20:22 +0100
Subject: [PATCH v2 3/3] arm64: dts: sunxi: enable EHCI1, OHCI1 and USB
 PHY nodes in Pine64
In-Reply-To: <20161122155831.8724-3-icenowy@aosc.xyz>
References: <20161122155831.8724-1-icenowy@aosc.xyz>
 <20161122155831.8724-3-icenowy@aosc.xyz>
Message-ID: <20161123092022.tn5gymbvcw3kr6uy@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 11:58:31PM +0800, Icenowy Zheng wrote:
> Pine64 have two USB Type-A ports, which are wired to the two ports of
> A64 USB PHY, and the lower port is the EHCI/OHCI1 port.
> 
> Enable the necessary nodes to enable the lower USB port to work.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Fixed the prefix and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161123/82e757bd/attachment-0001.sig>
