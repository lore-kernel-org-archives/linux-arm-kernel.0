From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 10:53:43 +0800
Subject: [PATCH 4/7] drm/panel: Add Sinlinx SinA33 7" panel
In-Reply-To: <20160905200248.GB8596@lukather>
References: <20160901153204.11217-1-maxime.ripard@free-electrons.com>
 <20160901153204.11217-5-maxime.ripard@free-electrons.com>
 <66681473008583@web28j.yandex.ru> <20160905200248.GB8596@lukather>
Message-ID: <CAGb2v64Qbhd+MnbzEoN-51GYo5AYOXkEu+=ku_Gbq7-ww7GLPQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 4:02 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Mon, Sep 05, 2016 at 01:03:03AM +0800, Icenowy Zheng wrote:
>> Hi Everyone,
>>
>> 01.09.2016, 23:40, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> >  The SinA33 has an unidentified panel. Add the timings for it under a new
>> >  compatible.
>>
>>
>>
>> Excuse me...
>> I will ask a question which is not fully related to the patch here...
>> If I want to add a generic panel for Q8 tablets, what should it be called?
>> "allwinner,q8-lcd-panel-800x480"?
>
> I guess it's more of a question for Thierry, but it seems like the
> trend is to put the diagonal rather than the resolution in the
> compatibles.

I think Hans (CC-ed) has some q8 tablet that has a 1024x600 LCD.
Both variants are 7". Without the exact model number we would need
the resolution to tell them apart.

ChenYu
