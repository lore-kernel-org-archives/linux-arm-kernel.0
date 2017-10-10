From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 10 Oct 2017 13:10:15 +0200
Subject: [PATCH v4 03/12] arm64: dts: mt8173: remove "mediatek, mt8135-mmc"
 from mmc nodes
In-Reply-To: <bbbe8b1e-4ac8-95cf-5e47-24a9cac8cffc@gmail.com>
References: <1507627831-29323-1-git-send-email-chaotian.jing@mediatek.com>
 <1507627831-29323-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFrtBr_f2HxsNsLQ1s+-9Toni8pC82gFdVcHY+oQSPqOBA@mail.gmail.com>
 <bbbe8b1e-4ac8-95cf-5e47-24a9cac8cffc@gmail.com>
Message-ID: <CAPDyKFoGhq_+iiRS4dZscpBw+ttCOY1EzA_okXgpWwOdWUMKNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 October 2017 at 13:06, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
> On 10/10/2017 12:49 PM, Ulf Hansson wrote:
>>
>> On 10 October 2017 at 11:30, Chaotian Jing <chaotian.jing@mediatek.com>
>> wrote:
>>>
>>> devicetree bindings has been updated to support multi-platforms,
>>> so that each platform has its owns compatible name.
>>> And, this compatible name may used in driver to distinguish with
>>> other platform.
>>>
>>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>>
>>
>> I assume there is no dependency to the rest or the series on this, so
>> this can go via arm soc?
>>
>
>
> Not in the sense of a merge conflict or something, but mt8173-mmc won't work
> until patch 2/12 is merged as well. If we want to be conservative, we should
> wait for this patch until the next kernel release. In the end it's just a
> cleanup of the dtsi.

In such case I can pick it part of this series, just need your ack.

Kind regards
Uffe
