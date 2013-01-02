From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Wed, 2 Jan 2013 10:14:21 +0000
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
In-Reply-To: <50AC8ECA.1020906@pengutronix.de>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-4-git-send-email-anilkumar@ti.com>
 <50AC8ECA.1020906@pengutronix.de>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAD58A2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 13:50:26, Marc Kleine-Budde wrote:
> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> > Add a new address space/memory resource to d_can device tree node. D_CAN
> > RAM initialization is achieved through RAMINIT register which is part of
> > AM33XX control module address space. D_CAN RAM init or de-init should be
> > done by writing instance corresponding value to control module register.
> > 
> > Till we have a separate control module driver to write to control module,
> > d_can driver will handle the register writes to control module by itself.
> > So a new address space to represent this control module register is added
> > to d_can driver.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 

Hi Tony/Benoit,

Could you please pull this in?

Thanks
AnilKumar
