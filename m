From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 08:22:14 +0200
Subject: [PATCH v4 0/6] ARM: dts: sunxi: Add CAN node and can0_pins_a
 pinctrl settings
In-Reply-To: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
References: <1491330992-9876-1-git-send-email-menschel.p@posteo.de>
Message-ID: <20170405062214.ejc4irrypxjoqufu@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 08:36:26PM +0200, Patrick Menschel wrote:
> The Allwinner A10/A20 SoCs have an on-board CAN (Controller Area Network)
> controller. This patch adds the CAN core to the SoC's include files,
> sun4i-a10.dtsi and sun7i-a20.dtsi.
> 
> On linux-can mailing list was a discussion about updating the device tree bindings
> https://lkml.org/lkml/2015/9/17/220
> but it did not progress past writing the documentation file.
> Documentation/devicetree/bindings/net/can/sun4i_can.txt
> 
> The CAN controller can be enabled in a board specific dts file as
> described in the documentation file or by using a device tree overlay.

Applied 1 and 4. The others were already merged.

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
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/71ee61ec/attachment.sig>
