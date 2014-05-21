From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 May 2014 13:29:04 +0200
Subject: [PATCH v8 2/2] can: xilinx CAN controller support.
In-Reply-To: <30fc07d6-4404-4745-8c03-1c5ae775e4f1@BY2FFO11FD047.protection.gbl>
References: <30fc07d6-4404-4745-8c03-1c5ae775e4f1@BY2FFO11FD047.protection.gbl>
Message-ID: <537C8E00.404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2014 09:00 AM, Kedareswara rao Appana wrote:
> This patch adds xilinx CAN controller support.
> This driver supports both ZYNQ CANPS and Soft IP
> AXI CAN controller.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>

Looks good, do you already have an Ack for the DT-bindings?

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/b743c9b3/attachment.sig>
