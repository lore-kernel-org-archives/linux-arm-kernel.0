From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 6 Apr 2016 01:39:31 -0300
Subject: [PATCH 4/5] devicetree: leds: Introduce "panic-blink" optional
 property
In-Reply-To: <5704301D.7040300@gmail.com>
References: <1459801326-5541-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1459801326-5541-5-git-send-email-ezequiel@vanguardiasur.com.ar>
 <5704301D.7040300@gmail.com>
Message-ID: <CAAEAJfCqgiuf2uLbqA8K3fuAkiriodxL2wG4bnLeHWpsU2ULbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 April 2016 at 18:37, Jacek Anaszewski <jacek.anaszewski@gmail.com> wrote:
> Hi Ezequiel,
>
> On 04/04/2016 10:22 PM, Ezequiel Garcia wrote:
>>
>> It's desirable to specify which LEDs are to be blinked on a kernel
>> panic. Therefore, introduce a devicetree boolean property to mark
>> which LEDs should be treated this way.
>>
>> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> ---
>>   Documentation/devicetree/bindings/leds/common.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/common.txt
>> b/Documentation/devicetree/bindings/leds/common.txt
>> index 68419843e32f..dd409df9203a 100644
>> --- a/Documentation/devicetree/bindings/leds/common.txt
>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>> @@ -37,6 +37,8 @@ Optional properties for child nodes:
>>                        property is mandatory for the LEDs in the non-flash
>> modes
>>                        (e.g. torch or indicator).
>>
>> +- panic-blink : Mark this LED to be used by the panic LED trigger.
>
>
> I'd say that 'panic-indicator' would be more informative.
>

Sure, that looks much better.

> Please next time cc also devicetree list and maintainers.
>

Will do.

Thanks for the reviews!
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
