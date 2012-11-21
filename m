From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 Nov 2012 09:20:26 +0100
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
In-Reply-To: <1352916505-12343-4-git-send-email-anilkumar@ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-4-git-send-email-anilkumar@ti.com>
Message-ID: <50AC8ECA.1020906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> Add a new address space/memory resource to d_can device tree node. D_CAN
> RAM initialization is achieved through RAMINIT register which is part of
> AM33XX control module address space. D_CAN RAM init or de-init should be
> done by writing instance corresponding value to control module register.
> 
> Till we have a separate control module driver to write to control module,
> d_can driver will handle the register writes to control module by itself.
> So a new address space to represent this control module register is added
> to d_can driver.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/9f7108bb/attachment.sig>
