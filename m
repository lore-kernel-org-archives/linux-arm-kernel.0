From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu, 25 Feb 2016 08:42:57 +0800
Subject: [PATCH 3/4] clk: rockchip: add dt-binding header for rk3399
In-Reply-To: <4483822.0pRK7cKepF@phil>
References: <1456210864-29037-1-git-send-email-jay.xu@rock-chips.com>
 <1456210864-29037-4-git-send-email-jay.xu@rock-chips.com>
 <4483822.0pRK7cKepF@phil>
Message-ID: <56CE4E11.7090808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:

? 24/02/2016 21:27, Heiko Stuebner ??:
> Hi Jianqun,
>
> Am Dienstag, 23. Februar 2016, 15:01:03 schrieb jianqun.xu:
>> From: Xing Zheng <zhengxing@rock-chips.com>
>>
>> Add the dt-bindings header for the rk3399, that gets shared between
>> the clock controller and the clock references in the dts.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>
> looks ok so far, do you have an estimate when the revised clk driver will be
> sent? Before committing to support this binding header forever I'd like to
> take a look over the clock-tree itself, just to be sure ;-)
>
No problem, since the cru head file is needed by many drivers, so it 
must be pushed as
soon as possible.

It's better to send the clk driver by Xing in a separate patch. I will 
co-work with xing.

Thanks
>
> Thanks
> Heiko
>
>
>
