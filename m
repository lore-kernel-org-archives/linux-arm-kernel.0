From: gabriel.fernandez@st.com (Gabriel Fernandez)
Date: Wed, 6 Jul 2016 09:39:10 +0200
Subject: [PATCH 2/4] dt-bindings: Document the STM32 reset bindings
In-Reply-To: <20160705161813.GA20477@rob-hp-laptop>
References: <1467640052-6770-1-git-send-email-gabriel.fernandez@st.com>
 <1467640052-6770-2-git-send-email-gabriel.fernandez@st.com>
 <20160705161813.GA20477@rob-hp-laptop>
Message-ID: <577CB59E.1080508@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for reviewing

On 07/05/2016 06:18 PM, Rob Herring wrote:
> On Mon, Jul 04, 2016 at 03:47:30PM +0200, gabriel.fernandez at st.com wrote:
>> From: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>
>> This adds documentation of device tree bindings for the
>> STM32 reset controller.
>>
>> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> ---
>>   .../devicetree/bindings/reset/st,stm32-rcc.txt     | 50 ++++++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>> new file mode 100644
>> index 0000000..333080c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/st,stm32-rcc.txt
>> @@ -0,0 +1,50 @@
>> +STMicroelectronics STM32 Peripheral Reset Controller
>> +====================================================
>> +
>> +The RCC IP is both a reset and a clock controller. This documentation only
>> +documents the reset part.
> The clock part is already documented or will do later? Either way, you
> are describing an IP block, so please describe all of it now and in one
> place.
>
> Rob
The clock part is already documented.

Okay to put this in one place, but in which directory ?
what do you prefer ?
- create a rcc directory
- put the file on top, in Documentation/devicetree/bindings

Best regards

Gabriel
