From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 21 Nov 2012 09:20:57 +0100
Subject: [PATCH 3/3] ARM: dts: AM33XX: Add memory resource to d_can node
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA778F3@DBDE01.ent.ti.com>
References: <1352916505-12343-1-git-send-email-anilkumar@ti.com>
 <1352916505-12343-4-git-send-email-anilkumar@ti.com>
 <50AB57B0.7040502@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA7701D@DBDE01.ent.ti.com>
 <50AB5AD8.7060407@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA778F3@DBDE01.ent.ti.com>
Message-ID: <50AC8EE9.7040508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2012 06:45 AM, AnilKumar, Chimata wrote:
> On Tue, Nov 20, 2012 at 15:56:32, Marc Kleine-Budde wrote:
>> On 11/20/2012 11:23 AM, AnilKumar, Chimata wrote:
>>> On Tue, Nov 20, 2012 at 15:43:04, Marc Kleine-Budde wrote:
>>>> On 11/14/2012 07:08 PM, AnilKumar Ch wrote:
>>>>> Add a new address space/memory resource to d_can device tree node. D_CAN
>>>>> RAM initialization is achieved through RAMINIT register which is part of
>>>>> AM33XX control module address space. D_CAN RAM init or de-init should be
>>>>> done by writing instance corresponding value to control module register.
>>>>>
>>>>> Till we have a separate control module driver to write to control module,
>>>>> d_can driver will handle the register writes to control module by itself.
>>>>> So a new address space to represent this control module register is added
>>>>> to d_can driver.
>>>>>
>>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>>
>>>> This does not apply to net-next/master:
>>>>
>>>> Applying: ARM: dts: AM33XX: Add memory resource to d_can node
>>>> error: patch failed: arch/arm/boot/dts/am33xx.dtsi:227
>>>> error: arch/arm/boot/dts/am33xx.dtsi: patch does not apply
>>>> Patch failed at 0003 ARM: dts: AM33XX: Add memory resource to d_can node
>>>>
>>>
>>> Marc,
>>>
>>> Sorry about this DT changes are present in linux-omap.
>>>
>>> Could you please take the driver changes only and ACK on remaining will
>>> help.
>>
>> Will do - I'm currently looking at the driver.
>>
> 
> Hi Marc,
> 
> Please ACK this patch as well.

done :)

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
Size: 261 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121121/bd0758cf/attachment.sig>
