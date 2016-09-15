From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Sep 2016 10:35:30 +0200
Subject: [PATCH] ARM: dts: sun8i: enable UART1 for iNet D978 Rev2 board
In-Reply-To: <1262161473906138@web14h.yandex.ru>
References: <20160915021504.65483-1-icenowy@aosc.xyz>
 <1262161473906138@web14h.yandex.ru>
Message-ID: <20160915083530.GD10128@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 10:22:18AM +0800, Icenowy Zheng wrote:
> 
> 
> 15.09.2016, 10:15, "Icenowy Zheng" <icenowy@aosc.xyz>:
> > UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
> > on iNet D978 Rev2 board.
> >
> > Enable the UART1 to make it possible to use the modified hciattach by
> > Realtek to drive the BT part of RTL8723BS.
> >
> > On the board no r_uart pins are found now (the onboard RX/TX pins are
> > wired to PF2/PF4, which is muxed with mmc0), so also disabled it.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> 
> Oh I forgot to add a patch version number...
> It's PATCH v3.
> 
> (But it seems that I should send a v4 to split the dtsi change and dts change.)

Indeed :)

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160915/792e2739/attachment.sig>
