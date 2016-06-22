From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 22 Jun 2016 22:34:09 +0200
Subject: [PATCH v2 0/2] can: rcar_canfd: Add Classical CAN & lower state
 transition support
In-Reply-To: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <602d4286-754f-f02f-4bd2-3e238cc4789a@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22/2016 02:31 PM, Ramesh Shanmugasundaram wrote:
> This patch is based on latest can-next(tag:linux-can-next-for-4.8-20160617).
> 
> Changes since v1:
>  - property named changed from "can-nofd" to "no-can-fd" (Rob H)
>  - added new patch(0002) that support lower state transitions (Wolfgang G)
>    (http://marc.info/?l=linux-can&m=146650325116971&w=2)
> 
> Ramesh Shanmugasundaram (2):
>   can: rcar_canfd: Add Classical CAN only mode support
>   can: rcar_canfd: Add back-to-error-active support
> 
>  .../devicetree/bindings/net/can/rcar_canfd.txt     |  21 +-
>  drivers/net/can/rcar/rcar_canfd.c                  | 429 ++++++++++++++-------
>  2 files changed, 310 insertions(+), 140 deletions(-)

Applied to can-next.

Tnx,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160622/1f4270e1/attachment.sig>
