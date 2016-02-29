From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 29 Feb 2016 10:34:59 +0100
Subject: [PATCH 0/2] Add CAN support to r8a7795 SoC
In-Reply-To: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <56D410C3.7020106@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2016 10:20 AM, Ramesh Shanmugasundaram wrote:
> This patch set adds CAN support to r8a7795 SoC.
> 
> This is based on linux-next (tag: next-20160225).

Please rebase to tags/linux-can-next-for-4.6-20160226 of
git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git

> Pinctrl & Clock related to the controller are already submitted as below:
> 
> https://lkml.org/lkml/2016/2/25/546
> https://lkml.org/lkml/2016/2/26/452
> http://www.spinics.net/lists/arm-kernel/msg487238.html
> 
> The compatibility string used follows the same format as in this patch:
> http://www.spinics.net/lists/netdev/msg365756.html
> 
> Ramesh Shanmugasundaram (2):
>   can: rcar_can: Add r8a7795 support
>   arm64: dts: r8a7795: Add CAN support
> 
>  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++++++++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 30 ++++++++++++++++++++++
>  drivers/net/can/Kconfig                            |  2 +-
>  drivers/net/can/rcar_can.c                         |  7 ++++-
>  4 files changed, 49 insertions(+), 2 deletions(-)
> 

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
Size: 455 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/db326cba/attachment.sig>
