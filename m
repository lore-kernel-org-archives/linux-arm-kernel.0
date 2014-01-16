From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 16 Jan 2014 09:33:20 +0800
Subject: [PATCH 3/3] Binding: atmel-wm8904: add option to choose clock
In-Reply-To: <20140115115417.GA9558@ns203013.ovh.net>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-4-git-send-email-voice.shen@atmel.com>
 <20140115115417.GA9558@ns203013.ovh.net>
Message-ID: <52D736E0.90207@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi J,

On 01/15/2014 07:54 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 11:25 Tue 14 Jan     , Bo Shen wrote:
>> Add the option to choose clock output on which pin connect to SSC.
>> Default is on TK pin to SSC, add clk_from_rk_pin option, the clock
>> is on RK pin to SSC.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>
>>   Documentation/devicetree/bindings/sound/atmel-wm8904.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> index 8bbe50c..68a5c1a 100644
>> --- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> +++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> @@ -33,6 +33,8 @@ Required properties:
>>
>>   Optional properties:
>>     - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
>> +  - clk_from_rk_pin: according to hardware design, clk privide on rk pin
> 							  provide
>
> 	?? no example?

If this patch set is acceptable. The sama5 audio will use it (I will 
send patch after this patch set). Do I still need to put the example in 
the binding document?

>> +    to ssc device
>>
>>   Example:
>>   sound {
>> --
>> 1.8.5.2
>>

Best Regards,
Bo Shen
