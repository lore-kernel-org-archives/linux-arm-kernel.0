From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 20 Nov 2012 11:51:42 +0100
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add d_can instances to aliases
In-Reply-To: <1352916505-12343-3-git-send-email-anilkumar@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-3-git-send-email-anilkumar@ti.com>
Message-ID: <50AB60BE.1080002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> Add d_can instances to aliases node to get the D_CAN instance number
> from the driver. To initialize D_CAN message RAM, corresponding instance
> number is required.
> 
> To initialize instance 0 message RAM then 0x1 should be written and for
> instance 1 message RAM, 0x2 should be written to control module register.
> 
> With device-tree framework ip instance number is "-1" by default for all
> instances. To get device id/instance number then modules should be added
> to DT "aliases" node. of_alias_get_id() gives the device id number based
> on number of alias nodes present in "aliases node".
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121120/7f5902dc/attachment.sig>
