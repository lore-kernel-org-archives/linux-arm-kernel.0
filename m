From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 21 Oct 2015 20:18:54 -0500
Subject: [PATCH v1 1/2] dt-bindings: Sync the dts to this document
In-Reply-To: <CAL_JsqJcwWkMXQzo6PbO2kfv3h7hkqtq6CJW0+W4Wc3eh6RTuQ@mail.gmail.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
 <1445395380-5365-2-git-send-email-wxt@rock-chips.com>
 <CAL_JsqJ6ZRjZbtc7dqo-g=CzO+H_FWcRqs2gBGH2HMBBM1xU3g@mail.gmail.com>
 <5627B309.9080309@gmail.com>
 <CAL_JsqJcwWkMXQzo6PbO2kfv3h7hkqtq6CJW0+W4Wc3eh6RTuQ@mail.gmail.com>
Message-ID: <CAL_JsqJFO8u0-3BSwBrBh4m7z4iEDPYLeEM9Ef8SLvuj1FYXmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 21, 2015 at 11:48 AM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Oct 21, 2015 at 10:45 AM, Caesar Wang <caesar.upstream@gmail.com> wrote:
>> Hi Rob,
>>
>> ? 2015?10?21? 23:18, Rob Herring ??:
>>>
>>> On Tue, Oct 20, 2015 at 9:42 PM, Caesar Wang <wxt@rock-chips.com> wrote:
>>>>
>>>> Add the OTP gpio state, we need switch the pin to gpio state
>>>> before the TSADC controller is reset.

Also, please fix the subject to be specific what binding you are changing.

dt-bindings: rockchip-thermal: <what the change is>

Rob
