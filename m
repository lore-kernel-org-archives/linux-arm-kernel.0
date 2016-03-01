From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 1 Mar 2016 09:12:42 +0100
Subject: [PATCH] arm64: dts: r8a7795: Add CAN support
In-Reply-To: <1456755759-51288-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456755759-51288-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <56D54EFA.6020105@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/29/2016 03:22 PM, Ramesh Shanmugasundaram wrote:
> Adds CAN controller nodes for r8a7795.
> 
> Note: CAN channel register base address mentioned in R-Car Gen3 Hardware
> User Manual v0.5E is incorrect. The corrected base addresses are:
> 
> CAN Channel 0 - 0xe6c30000
> CAN Channel 1 - 0xe6c38000
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> Hi All,
> 
>    This patch is based on linux-next (tag:next-20160225) with following patch
>    applied on top

Who should take this patch?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160301/dd48dafe/attachment.sig>
