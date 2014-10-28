From: dianders@chromium.org (Doug Anderson)
Date: Tue, 28 Oct 2014 09:05:26 -0700
Subject: [PATCH v3 2/6] pinctrl: rockchip: save and restore gpio6_c6
 pinmux in suspend/resume
In-Reply-To: <CACRpkda6ebV51bPeyn6qsR97CdeV6nSTTsJmHmrcj-C0OXyDEw@mail.gmail.com>
References: <1413862894-2623-1-git-send-email-zyw@rock-chips.com>
 <1413863011-2736-1-git-send-email-zyw@rock-chips.com>
 <CACRpkda6ebV51bPeyn6qsR97CdeV6nSTTsJmHmrcj-C0OXyDEw@mail.gmail.com>
Message-ID: <CAD=FV=V2jEdZN0T54OezG5WTgEijN33EYUeuUXk8LCiTvhxn0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

On Tue, Oct 28, 2014 at 8:52 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 21, 2014 at 5:43 AM,  <zyw@rock-chips.com> wrote:
>
>> From: Chris Zhong <zyw@rock-chips.com>
>>
>> Save and restore the gpio6_c6 pinmux setting, since Maskrom of RK3288
>> would modify it to sdmmc0_det, so it need to be restored to the correct
>> setting after resume from Maskrom.
>>
>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>
> Heiko, ping on this too.

There's a newer version with his review (v5).  For this series see:

pinctrl: rockchip: save and restore gpio6_c6 pinmux in suspend/resume
https://patchwork.kernel.org/patch/5160781/ -

pinctrl: rockchip: add suspend/resume functions
https://patchwork.kernel.org/patch/5160761/
