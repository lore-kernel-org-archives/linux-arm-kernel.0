From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Aug 2016 13:42:51 +0200
Subject: [PATCH 2/2] ARM: dts: sun8i: Add extra UART pinmux settings for
 A23/33
In-Reply-To: <20160823055826.20591-2-icenowy@aosc.xyz>
References: <20160823055826.20591-1-icenowy@aosc.xyz>
 <20160823055826.20591-2-icenowy@aosc.xyz>
Message-ID: <20160823114251.GL2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 23, 2016 at 01:58:26PM +0800, Icenowy Zheng wrote:
> A23/33 have 4 UART controllers outside PRCM. However, the devicetree used
> to mentioned only UART0's pinmux settings. Some extra UART controllers have
> RTS/CTS, and is suitable for using as bluetooth UART controller.
> 
> Add the pinmux settings for the UART controller, to make use of the
> bluetooth function of some tablets.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Our policy is that we avoid adding unused pinctrl nodes to not cripple
the DT for no particular reason.

So please add only the nodes you'll need in your tablet.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/6b013030/attachment.sig>
