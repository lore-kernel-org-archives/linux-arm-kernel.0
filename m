From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Nov 2016 10:19:04 +0100
Subject: [PATCH v2 2/3] arm64: dts: sunxi: sort the nodes in
 sun50i-a64-pine64.dts
In-Reply-To: <20161122155831.8724-2-icenowy@aosc.xyz>
References: <20161122155831.8724-1-icenowy@aosc.xyz>
 <20161122155831.8724-2-icenowy@aosc.xyz>
Message-ID: <20161123091904.lxhofakxqu5vtj6m@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 11:58:30PM +0800, Icenowy Zheng wrote:
> In this dts file, uart0 node is put before i2c1.
> 
> Move the uart0 node to the end to satisfy alphebetical order.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Fixed the prefix and applied. Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161123/cad4f8e8/attachment.sig>
