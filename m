From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Wed, 2 Jan 2013 10:13:53 +0000
Subject: [PATCH 2/3] ARM: dts: AM33XX: Add d_can instances to aliases
In-Reply-To: <50AB60BE.1080002@pengutronix.de>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-3-git-send-email-anilkumar@ti.com>
 <50AB60BE.1080002@pengutronix.de>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAD4881@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 16:21:42, Marc Kleine-Budde wrote:
> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
> > Add d_can instances to aliases node to get the D_CAN instance number
> > from the driver. To initialize D_CAN message RAM, corresponding instance
> > number is required.
> > 
> > To initialize instance 0 message RAM then 0x1 should be written and for
> > instance 1 message RAM, 0x2 should be written to control module register.
> > 
> > With device-tree framework ip instance number is "-1" by default for all
> > instances. To get device id/instance number then modules should be added
> > to DT "aliases" node. of_alias_get_id() gives the device id number based
> > on number of alias nodes present in "aliases node".
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Tony/Benoit,

Could you please pull this in?

Thanks
AnilKumar
