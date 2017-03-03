From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 3 Mar 2017 22:36:02 +0100
Subject: [PATCH v3 03/25] dt-bindings: timer: Document Owl timer
In-Reply-To: <20170303062058.yvekr5kawqtzxgpn@rob-hp-laptop>
References: <20170228063535.32069-1-afaerber@suse.de>
 <20170228063535.32069-4-afaerber@suse.de> <20170228123908.GG3691@leverpostej>
 <20170303062058.yvekr5kawqtzxgpn@rob-hp-laptop>
Message-ID: <cef60449-a6e3-c513-d1d8-ed5824fc0550@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 03.03.2017 um 07:20 schrieb Rob Herring:
> On Tue, Feb 28, 2017 at 12:39:08PM +0000, Mark Rutland wrote:
>> On Tue, Feb 28, 2017 at 07:35:13AM +0100, Andreas F?rber wrote:
>>> The Actions Semi S500 SoC contains a timer block with two 2 Hz and two
>>> 32-bit timers. The S900 SoC timer block has four 32-bit timers.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>>  v2 -> v3:
>>>  * Adopted interrupt-names
>>>  * Changed compatible for S500
>>>  * Added S900 compatible and interrupt names
>>>  
>>>  v2: new
>>>  
>>>  .../devicetree/bindings/timer/actions,owl-timer.txt  | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/timer/actions,owl-timer.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/timer/actions,owl-timer.txt b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
>>> new file mode 100644
>>> index 0000000..5b4834d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/timer/actions,owl-timer.txt
>>> @@ -0,0 +1,20 @@
>>> +Actions Semi Owl Timer
>>> +
>>> +Required properties:
>>> +- compatible      :  "actions,s500-timer" for S500
>>> +                     "actions,s900-timer" for S900
>>> +- reg             :  Offset and length of the register set for the device.
>>> +- interrupts      :  Should contain the interrupts.
>>> +- interrupt-names :  Valid names are: "2Hz0", "2Hz1",
>>> +                                      "Timer0", "Timer1", "Timer2", "Timer3"
>>
>> Sticking to lower case for the names would be preferable.

Done.

> With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
