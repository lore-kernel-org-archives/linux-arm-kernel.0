From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 11 Apr 2017 23:02:38 +0800
Subject: [linux-sunxi] Re: [PATCH v2 03/11] dt-bindings: add device tree
 binding for X-Powers AXP803 PMIC
In-Reply-To: <alpine.LNX.2.20.1704112237290.39759@x220i>
References: <20170407183441.58750-1-icenowy@aosc.io>
 <20170407183441.58750-4-icenowy@aosc.io>
 <20170411140427.doq5atxk6ptjrp36@dell>
 <alpine.LNX.2.20.1704112237290.39759@x220i>
Message-ID: <CAGb2v65UiFqjYES3hF-S6THZ5Xu-HRS9R7Ngk8xeP1rZajsr7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 11, 2017 at 11:00 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
>
>
> On Tue, 11 Apr 2017, Lee Jones wrote:
>
>> On Sat, 08 Apr 2017, Icenowy Zheng wrote:
>>
>>> AXP803 is a PMIC produced by Shenzhen X-Powers, with either I2C or RSB
>>> bus.
>>>
>>> Add a compatible for it.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>> Changes in v2:
>>> - Place AXP803 before AXP806/809.
>>> - Added Chen-Yu's ACK.
>>>
>>>  Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>>
>> For my own reference:
>>  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
>
> Excuse me... Who will apply this patch?
>
> I think this patch should be applied by you as it's in bindings/mfd
> directory, however, if I'm wrong, please point out ;-)

We need the DT maintainers to ack it first. :)

ChenYu
