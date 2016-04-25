From: dianders@chromium.org (Doug Anderson)
Date: Mon, 25 Apr 2016 15:23:20 -0700
Subject: [PATCH RESEND v2 4/4] ARM64: dts: rockchip: add dts file for
 RK3399 evaluation board
In-Reply-To: <4687144.rPskt7YEHJ@diego>
References: <1461304307-14113-1-git-send-email-jay.xu@rock-chips.com>
 <1461304307-14113-5-git-send-email-jay.xu@rock-chips.com>
 <571D7723.1020707@gmail.com> <4687144.rPskt7YEHJ@diego>
Message-ID: <CAD=FV=UQxoGYsrw8C2VT_-oYs3ZuJQ6eM1HAFemoGrcDJoOHfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 25, 2016 at 12:37 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> Can we add the following strings to match the loader (coreboot)?
>>   No matter, we can match the loader(coreboot) to bring up the evb board
>> on now or in the future.
>>
>> ...,"google,rk3399evb-rev3",
>> google,rk3399evb-rev2",google,rk3399evb-rev1","google,rk3399evb-rev0"
>
> Yep, that should be no problem ... i.e. we also have this longer list of board
> matches for the previous veyron boards (both in the dts files as well as the
> board-binding document)

Just to make sure we're on the same page: I presume we're expecting
the Jay spin with this change?

-Doug
