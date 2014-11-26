From: dianders@chromium.org (Doug Anderson)
Date: Tue, 25 Nov 2014 16:49:08 -0800
Subject: [PATCH 1/2] clk: rockchip: add binding ID for DMC (memory
 controller) clocks on rk3288
In-Reply-To: <1717801.sWHeWsmqUi@diego>
References: <1416960783-25119-1-git-send-email-dianders@chromium.org>
 <1717801.sWHeWsmqUi@diego>
Message-ID: <CAD=FV=WxeFFZekYOkttx4YcDq=td+Vpu9rFALuNu_6zs+7b2tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Nov 25, 2014 at 4:45 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Dienstag, 25. November 2014, 16:13:02 schrieb Doug Anderson:
>> From: Jeff Chen <cym@rock-chips.com>
>>
>> The DMC clocks need to be turned off at runtime, so we should have IDs
>> so we can export them.
>>
>> Signed-off-by: Jeff Chen <cym@rock-chips.com>
>> [dianders: split into two patches; adjusted commit msg]
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>
> both patches look ok to me and I'll probably pick them up tomorrow.

OK, thanks!


> Just as handling question, do you plan on sending dts changes using these
> clocks in time for 3.19 [i.e. in the next couple of days]?

There's pretty much zero chance.  Maybe negative.


> We have currently three clock patches/series adding new clock ids [this one,
> the mmc phases and Sonny's i2s_clkout] and I'm trying to dertermine if I need
> a shared branch for those.
>
> Currently it doesn't look like the others will provide dts patches using the
> clocks in time, so it looks like I can skip the shared branch and we can use
> the clock ids regularly after the merge-window. Some true for your clocks?

Yup, no problem for me.  I provided this as two patches to you just in
case it was convenient, since I saw that as feedback in previous
submissions.

Thanks!

-Doug
