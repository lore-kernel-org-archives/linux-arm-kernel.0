From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Sep 2016 10:18:48 +0200
Subject: [PATCH v4 2/2] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2
 board
In-Reply-To: <20160916151642.27907-2-icenowy@aosc.xyz>
References: <20160916151642.27907-1-icenowy@aosc.xyz>
 <20160916151642.27907-2-icenowy@aosc.xyz>
Message-ID: <20160919081848.GC8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 11:16:42PM +0800, Icenowy Zheng wrote:
> UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
> on iNet D978 Rev2 board.
> 
> Enable the UART1 to make it possible to use the modified hciattach by
> Realtek to drive the BT part of RTL8723BS.
> 
> On the board no r_uart pins are found now (the onboard RX/TX pins are
> wired to PF2/PF4, which is muxed with mmc0), so also disabled it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160919/3d283f19/attachment-0001.sig>
