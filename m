From: jay.xu@rock-chips.com (jay.xu)
Date: Tue, 26 Apr 2016 09:27:16 +0800
Subject: [PATCH RESEND v2 4/4] ARM64: dts: rockchip: add dts file for
 RK3399 evaluation board
In-Reply-To: <CAD=FV=UQxoGYsrw8C2VT_-oYs3ZuJQ6eM1HAFemoGrcDJoOHfw@mail.gmail.com>
References: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
 <1461304307-14113-5-git-send-email-jay.xu@rock-chips.com>
 <571D7723.1020707@gmail.com> <4687144.rPskt7YEHJ@diego>
 <CAD=FV=UQxoGYsrw8C2VT_-oYs3ZuJQ6eM1HAFemoGrcDJoOHfw@mail.gmail.com>
Message-ID: <571EC3F4.2070703@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug:

On 2016?04?26? 06:23, Doug Anderson wrote:
> Hi,
>
> On Mon, Apr 25, 2016 at 12:37 AM, Heiko St?bner <heiko@sntech.de> wrote:
>>> Can we add the following strings to match the loader (coreboot)?
>>>    No matter, we can match the loader(coreboot) to bring up the evb board
>>> on now or in the future.
>>>
>>> ...,"google,rk3399evb-rev3",
>>> google,rk3399evb-rev2",google,rk3399evb-rev1","google,rk3399evb-rev0"
>>
>> Yep, that should be no problem ... i.e. we also have this longer list of board
>> matches for the previous veyron boards (both in the dts files as well as the
>> board-binding document)
>
> Just to make sure we're on the same page: I presume we're expecting
> the Jay spin with this change?
>
Got it, and do you think it's better to use rk3399-evb-rev1 but 
rk3399evb-rev1, since the dts use rk3399-evb ?

Anyway I just want to point out that we needn't to fix in the future.

> -Doug
>
>
>
