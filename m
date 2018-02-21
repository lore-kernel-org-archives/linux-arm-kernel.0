From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 21 Feb 2018 19:05:57 +0100
Subject: [PATCH 05/10] dt-bindings: gpio: Add gpio nodes for Actions S900
 SoC
In-Reply-To: <20180221145821.bhoxjndibp3bqfxi@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-6-manivannan.sadhasivam@linaro.org>
 <20180219203523.rhvbnym7oomzahwi@rob-hp-laptop>
 <20180221145821.bhoxjndibp3bqfxi@linaro.org>
Message-ID: <ac193690-220e-4160-5dd5-6ddeaea4d5d0@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.02.2018 um 15:58 schrieb Manivannan Sadhasivam:
> Hi Rob,
> On Mon, Feb 19, 2018 at 02:35:23PM -0600, Rob Herring wrote:
>> On Sun, Feb 18, 2018 at 02:14:28AM +0530, Manivannan Sadhasivam wrote:
>>> Add gpio nodes for Actions Semi S900 SoC.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> ---
>>>  .../devicetree/bindings/gpio/actions,owl-gpio.txt         | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
>>> new file mode 100644
>>> index 000000000000..4cd4cb7bfd1b
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
>>> @@ -0,0 +1,15 @@
>>> +* Actions Semi OWL GPIO controller bindings
>>> +
>>> +- compatible      : Should be "actions,s900-gpio"
>>> +- reg             : Address and range of the GPIO controller registers.
>>> +- gpio-controller : Marks the device node as a GPIO controller.
>>> +- #gpio-cells     : Should be <2>. The first cell is the gpio number and
>>> +                    the second cell is used to specify optional parameters.
>>
>> Doesn't do interrupts?
>>
> Interrupt support will be added once this base driver gets in.
> One step at a time ;-)

Rob rejected that step-by-step approach for my RDA Micro bindings, which
is why it is currently stuck. ;)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
