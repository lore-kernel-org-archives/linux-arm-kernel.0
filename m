From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 26 Jul 2012 11:14:57 +0200
Subject: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA04433@DBDE01.ent.ti.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com>
 <1343219012-19472-2-git-send-email-anilkumar@ti.com>
 <9D2B44C8-820E-4E96-A480-7A650583BC92@dominion.thruhere.net>
 <331ABD5ECB02734CA317220B2BBEABC13EA04433@DBDE01.ent.ti.com>
Message-ID: <50110A91.2080508@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/26/2012 11:03 AM, AnilKumar, Chimata wrote:
> On Thu, Jul 26, 2012 at 14:16:33, Koen Kooi wrote:
>>
>> Op 25 jul. 2012, om 14:23 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
>>
>>> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
>>> by adding d_can device node with all the necessary parameters.
>>>
>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>> ---
>>> arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
>>> index 9b974dc..2db2ffb 100644
>>> --- a/arch/arm/boot/dts/am33xx.dtsi
>>> +++ b/arch/arm/boot/dts/am33xx.dtsi
>>> @@ -163,5 +163,10 @@
>>> 			#size-cells = <0>;
>>> 			ti,hwmods = "i2c3";
>>> 		};
>>> +
>>> +		dcan1: d_can at 481D0000 {
>>> +			compatible = "bosch,d_can";
>>> +			ti,hwmods = "d_can1";
>>> +		};
>>> 	};
>>
>> I scanned the linux-networking mailinglist and l-o-ml, but I can't find the patchset that actually adds the d_can drivers, could you provide a link to that? I have 2 different CAN capes I'd like to test on beaglebone.
>>
> 
> You can find it from linux-next or net-next trees, D_CAN support is added
> to C_CAN driver.
> 
> http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;
> a=commitdiff;h=69927fccd96b15bd228bb82d356a7a2a0cfaeefb

Meanwhile it's in Linus's git tree.

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120726/074c155e/attachment.sig>
