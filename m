From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 31 Aug 2016 18:22:40 +0200
Subject: [PATCH v3] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <20160829141832.10566-1-icenowy@aosc.xyz>
References: <20160829141832.10566-1-icenowy@aosc.xyz>
Message-ID: <20160831162240.GJ14379@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 10:18:32PM +0800, Icenowy Zheng wrote:
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

I'll make the same comments than in the v2.
https://www.spinics.net/lists/arm-kernel/msg527001.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/5d5b5392/attachment-0001.sig>
