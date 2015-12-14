From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 14 Dec 2015 16:53:42 +0300
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <201512140456.08114.marex@denx.de>
References: <20151211110700.GD11252@tiger>
 <1449890833-7195-1-git-send-email-marex@denx.de>
 <20151214013845.GP11252@tiger> <201512140456.08114.marex@denx.de>
Message-ID: <566EC9E6.6060402@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12/14/2015 6:56 AM, Marek Vasut wrote:

>>> From: Sean Cross <xobs@kosagi.com>
>>>
>>> Novena is an open-hardware laptop/desktop/bare board.
>>>
>>> See http://www.kosagi.com/w/index.php?title=Novena_Main_Page
>>>
>>> Signed-off-by: Sean Cross <xobs@kosagi.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>>> Cc: Lucas Stach <l.stach@pengutronix.de>
>>> Cc: Sean Cross <xobs@kosagi.com>
>>> Cc: Shawn Guo <shawnguo@kernel.org>
>>
>> It looks pretty good to me now, except a small question below.
>
> Thanks
>
>>> ---
>>>
>>>   arch/arm/boot/dts/Makefile         |   1 +
>>>   arch/arm/boot/dts/imx6q-novena.dts | 789
>>>   +++++++++++++++++++++++++++++++++++++ 2 files changed, 790
>>>   insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
>>
>> <snip>
>>
>>> +/ {
>>> +	model = "Kosagi Novena Dual/Quad";
>>> +	compatible = "kosagi,imx6q-novena", "fsl,imx6q";
>>> +
>>> +	memory {
>>> +		reg = <0x10000000 0xefffffff>;
>>
>> What's the trick of having memory size being 0xefffffff?

> That is a typo, should obviously be 0xffffffff ,

    You didn't get it. :-) It' the _size_, not limit.

[...]

> Best regards,
> Marek Vasut

MBR, Sergei
