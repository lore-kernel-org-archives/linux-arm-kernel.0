From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 10 Oct 2017 09:59:24 +0800
Subject: [PATCH v2 1/3] dt-bindings: Add document for rockchip RGB output
 interface
In-Reply-To: <CAL_JsqJcO6VtgYBzby+gjerODT9n6fE0aMNJXNejvvhF1nqM-Q@mail.gmail.com>
References: <1506049221-117283-1-git-send-email-hjc@rock-chips.com>
 <1506049229-117376-1-git-send-email-hjc@rock-chips.com>
 <20171003215631.rc2jsf2m3qgoltsb@rob-hp-laptop>
 <2d502a9d-e952-8afb-d2d7-45c21c36da7e@rock-chips.com>
 <CAL_JsqJcO6VtgYBzby+gjerODT9n6fE0aMNJXNejvvhF1nqM-Q@mail.gmail.com>
Message-ID: <e877b1d6-9365-6c26-fbca-8d307610c94a@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017/10/9 21:05, Rob Herring ??:
> On Mon, Oct 9, 2017 at 3:06 AM, Sandy Huang <hjc@rock-chips.com> wrote:
>> Hi rob,
>>      Thanks for your reply.
>>
>> ? 2017/10/4 5:56, Rob Herring ??:
>>>
>>> On Fri, Sep 22, 2017 at 11:00:26AM +0800, Sandy Huang wrote:
>>>>
>>>> This path add support rv1108 rgb output interface driver.
>>>>
>>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>>> ---
>>>> Changes in v2:
>>>>    1. rename rockchip,rgb-mode to rgb-mode;
>>>
>>>
>>> You can't just drop the vendor. This needs to be documented in a common
>>> place that others will find and use. See panel-common.txt or
>>> panel-dpi.txt.
>>>
>>> Alternatively, you could just drop it and let the panel compatible imply
>>> what the mode is.
>>>
>>>
>> ok, get it, i will move the rgb-mode to panel and describe it at
>> panel-rgb.txt. the patches will be send soon later.
> 
> Don't create yet another common panel file. We already have
> panel-dpi.txt which is for digital parallel interface.
> The panel-rgb.txt define different rgb output format and timing, this is 
the detail info: https://patchwork.kernel.org/patch/9992241/
do you think this need move to panel-dpi.txt?
> Rob
> 
> 
> 
