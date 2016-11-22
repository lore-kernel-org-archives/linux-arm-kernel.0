From: vladimir.barinov@cogentembedded.com (Vladimir Barinov)
Date: Tue, 22 Nov 2016 15:08:49 +0300
Subject: [PATCH 16/18] arm64: dts: h3ulcb: rename SDHI0 pins
In-Reply-To: <d4fbb71f-2a4d-2239-faa9-c017c74e1d79@cogentembedded.com>
References: <cover.1479726397.git.horms+renesas@verge.net.au>
 <93373c309a703b57690216db4106a4a534929c15.1479726397.git.horms+renesas@verge.net.au>
 <45a251f6-ee0c-5eba-ffd1-3f61a1e7ccc7@cogentembedded.com>
 <f4f57fbc-313c-669f-94c7-073747a20a82@cogentembedded.com>
 <d4fbb71f-2a4d-2239-faa9-c017c74e1d79@cogentembedded.com>
Message-ID: <8acc79fe-393d-2b69-b7e7-e87a53d95264@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On 22.11.2016 14:40, Sergei Shtylyov wrote:
> On 11/22/2016 2:22 PM, Vladimir Barinov wrote:
>
>>>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>>
>>>> This changes SDHI0 pin names for H3ULCB board
>>>>
>>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>>> ---
>>>>  arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
>>>> b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
>>>> index 8d0ac076d8e2..6ffb0517421a 100644
>>>> --- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
>>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
>>>> @@ -163,13 +163,13 @@
>>>>          function = "avb";
>>>>      };
>>>>
>>>> -    sdhi0_pins_3v3: sd0_3v3 {
>>>> +    sdhi0_pins: sd0 {
>>>>          groups = "sdhi0_data4", "sdhi0_ctrl";
>>>>          function = "sdhi0";
>>>>          power-source = <3300>;
>>>>      };
>>>>
>>>> -    sdhi0_pins_1v8: sd0_1v8 {
>>>> +    sdhi0_pins_uhs: sd0 {
>>>
>>>    I'm afraid the following will just override the props of the node 
>>> above
>>> which is not what we ant.
>> Thank you for pointing to this.
>>
>> This is my typo.
>> I will rework the patch to have different node names.
>
>    The patch had been already merged by Simon and was posted a s apart 
> of a pull request (if I don't mistake), so I guess an incremental 
> patch needed now...
Thanks for clarification.

I will make incremental patch.

Regards,
Vladimir

>
>> Regards,
>> Vladimir
>
> MBR, Sergei
>
