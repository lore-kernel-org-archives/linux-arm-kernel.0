From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 2 Sep 2016 09:43:14 +0200
Subject: [linux-sunxi] Re: [PATCH v3] ARM: dts: sun8i: enable UART1 for
 iNet D978 Rev2 board
In-Reply-To: <a3097f99-a761-76e7-1405-2574c56ac94d@redhat.com>
References: <20160829141832.10566-1-icenowy@aosc.xyz>
 <20160831162240.GJ14379@lukather>
 <a3097f99-a761-76e7-1405-2574c56ac94d@redhat.com>
Message-ID: <20160902074314.GC6313@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 01, 2016 at 10:40:32AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 31-08-16 18:22, Maxime Ripard wrote:
> >On Mon, Aug 29, 2016 at 10:18:32PM +0800, Icenowy Zheng wrote:
> >>UART1 is connected to the bluetooth part of RTL8723BS WiFi/BT combo card
> >>on iNet D978 Rev2 board.
> >>
> >>Enable the UART1 to make it possible to use the modified hciattach by
> >>Realtek to drive the BT part of RTL8723BS.
> >>
> >>On the board no r_uart pins are found now (the onboard RX/TX pins are
> >>wired to PF2/PF4, which is muxed with mmc0), so also disabled it.
> >>
> >>Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >
> >I'll make the same comments than in the v2.
> >https://www.spinics.net/lists/arm-kernel/msg527001.html
> 
> I've a feeling there is a bit of miscommunication here,
> let me try to clarify things:
> 
> Icenowy, Maxime wants you to split this into 2 patches:

Hmm, yes, sorry if it was unclear.

Thanks Hans

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/97f9d7fe/attachment.sig>
