From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Thu, 18 Sep 2014 10:33:05 +0800
Subject: [PATCH v5 2/4] dt-bindings: document Rockchip thermal
In-Reply-To: <20140917201347.GD25297@core.coreip.homeip.net>
References: <1410926353-15674-1-git-send-email-caesar.wang@rock-chips.com>
 <1410926353-15674-3-git-send-email-caesar.wang@rock-chips.com>
 <CAD=FV=Vq4zSBv-=OxHD4sGbAgLh_ebe29PR6RU_sQe4XspsPsw@mail.gmail.com>
 <20140917201347.GD25297@core.coreip.homeip.net>
Message-ID: <541A4461.4080101@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


? 2014?09?18? 04:13, Dmitry Torokhov ??:
> On Wed, Sep 17, 2014 at 12:48:16PM -0700, Doug Anderson wrote:
>> Caesar,
>>
>> On Tue, Sep 16, 2014 at 8:59 PM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
>>> This add the necessary binding documentation for the thermal
>>> found on Rockchip SoCs
>>>
>>> Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
>>> Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
>>> ---
>>>   .../bindings/thermal/rockchip-thermal.txt          | 41 ++++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> new file mode 100644
>>> index 0000000..6fc8bc3
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>> @@ -0,0 +1,41 @@
>>> +* Temperature Sensor ADC (TSADC) on rockchip SoCs
>>> +
>>> +Required properties:
>>> +- compatible: "rockchip,rk3288-tsadc"
>>> +- reg: physical base address of the controller and length of memory mapped
>>> +       region.
>>> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
>>> +             depends on the interrupt controller.
>>> +- clocks: Must contain an entry for each entry in clock-names.
>>> +- clock-names: Shall be "tsadc" for the converter-clock, and "apb_pclk" for
>>> +              the peripheral clock.
>>> +- num-trips:  number of total trip points, this is required, set it 0 if none,
>>> +             if greater than 0, the following properties must be defined;
>> nit: there is whitespace damage (space before tab) on the line before
>> this one.  It's more obvious in the patch you uploaded to gerrit which
>> highlights this in red:
>>
>> https://chromium-review.googlesource.com/#/c/213967/5/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
>>
>> Did you run your patches through checkpatch before submitting?
> FWIW vim users like me can put the following in their .vimrc file to
> have whitespace damage visible right away:
>
> :highlight RedundantSpaces ctermbg=red guibg=red
> :match RedundantSpaces /\s\+$\| \+\ze\t/
>
> Thanks.

It's a very useful, Thank you  for sharing.


-- 
Best regards,
Caesar
