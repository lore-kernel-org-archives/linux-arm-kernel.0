From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 23 Nov 2016 14:18:13 +0100
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
In-Reply-To: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 01:14 PM, Chris Paterson wrote:
> This patch series adds CAN and CAN FD support to the r8a7796.
> 
> Based on renesas-devel-20161122-v4.9-rc6.
> 
> Chris Paterson (3):
>   arm64: dts: r8a7796: Add CAN external clock support
>   arm64: dts: r8a7796: Add CAN support
>   arm64: dts: r8a7796: Add CAN FD support
> 
>  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
>  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61 ++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 10 deletions(-)

For all three:

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Who takes this series?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161123/1a4068ca/attachment.sig>
