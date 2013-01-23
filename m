From: liu.y.victor@gmail.com (Liu Ying)
Date: Wed, 23 Jan 2013 15:59:36 +0800
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Add at24c512b eeprom support
In-Reply-To: <20130123075525.GV1906@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <1358922764-31654-2-git-send-email-Ying.Liu@freescale.com>
 <20130123073059.GP1906@pengutronix.de>
 <CA+8Hj80ceGEUtzfvvEuH7ZftWGydzd9pHK_FxfE59WBxOst4rQ@mail.gmail.com>
 <20130123075525.GV1906@pengutronix.de>
Message-ID: <CA+8Hj83tsedqKXr8YzgR5L-fPZoTNyob4KAxmpE5CMDFuCgH=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/23 Sascha Hauer <s.hauer@pengutronix.de>:
> On Wed, Jan 23, 2013 at 03:51:12PM +0800, Liu Ying wrote:
>> 2013/1/23 Sascha Hauer <s.hauer@pengutronix.de>:
>> > On Wed, Jan 23, 2013 at 02:32:44PM +0800, Liu Ying wrote:
>> >> This patch adds at24c512b i2c device to the device tree
>> >> along with the necessary i2c device node and pinctrl
>> >> settings for i2c bus.
>> >> The eeprom chip is populated on the accessory board of
>> >> the imx51-babbage board.
>> >
>> > Given that it's optional should the binding be here anyway? I don't have
>> > this accessory board and this may conflict with the boards other people
>> > have connected on this port.
>> >
>> > Sascha
>>
>> Understand your concern. Is there any way to handle this? How can we support
>> the present accessory board correctly? More generally, not all main boards can
>> figure out what kind of accessory board is attached to them, at least, some main
>> boards can only figure out limited number of accessory boards by using some ways
>> of board ID check.
>
> We don't have support for such things atm. We'll have to wait for
>
> OF: Introduce DT overlay support.
>
> Pantelis Antoniou is working on this currently.
>
> Sascha
>
>
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Good to know that. Thanks.

-- 
Best Regards,
Liu Ying
