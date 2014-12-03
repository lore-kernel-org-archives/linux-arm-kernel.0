From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Dec 2014 21:18:35 -0800
Subject: [PATCH 2/2] ASoC: rockchip: i2s: add support for grabbing output
 clock to codec
In-Reply-To: <547E616C.1020503@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417531977-30094-1-git-send-email-jay.xu@rock-chips.com>
 <CAD=FV=Uwb1NxxCoXHzHu6DJCpnG_HV2RhCr3JaJaXbJja8kd7A@mail.gmail.com>
 <547E616C.1020503@rock-chips.com>
Message-ID: <CAD=FV=VtYU5Pdz-xvjSdsReyCqMQaMtw=ZXmH4PO5wFnGVPY1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 2, 2014 at 5:03 PM, Jianqun <xjq@rock-chips.com> wrote:
> Hi Doug:
>
> ? 12/03/2014 01:54 AM, Doug Anderson ??:
>> Jianqun,
>>
>> This ought to be a "v3" patch and ideally ought to describe
>> differences from v2 (after the cut).  Please have Kever or Chris
>> review your next patch before sending it out since I think they are
>> familiar with the process.

You still seem to be missing versions in your subject line and missing
info on what changed version to version.  The latest version you just
sent (v4?) is still missing it.

Unless Mark says so then I don't think you need to spin this series,
but please try to add that in the future.


>> You still forgot the blank line here requested by Heiko.  Please try
>> again.  See <https://patchwork.kernel.org/patch/5334991/>
> Although I thought there needn't a blank ~, I wll add it next patch

That would have been OK, but in that case you should have responded to
Heiko's patch and explained that you weren't taking his feedback (and
why you weren't).

-Doug
