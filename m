From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2017 09:46:53 +0100
Subject: [PATCH 6/8] Documentation: dt: Add new compatible to STM32
 pinctrl driver bindings
In-Reply-To: <abee01c1-da4f-97b4-258a-3ab937f620eb@st.com>
References: <1485533721-9019-1-git-send-email-alexandre.torgue@st.com>
 <1485533721-9019-7-git-send-email-alexandre.torgue@st.com>
 <20170201150609.cbhwon76m6igmhyh@rob-hp-laptop>
 <abee01c1-da4f-97b4-258a-3ab937f620eb@st.com>
Message-ID: <CACRpkdb=U+UMRqR2GKGwDzk9X_nLv0tf2dZ8LhDGceAD83LKag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 4:58 PM, Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 02/01/2017 04:06 PM, Rob Herring wrote:
>>
>> On Fri, Jan 27, 2017 at 05:15:19PM +0100, Alexandre TORGUE wrote:
>>>
>>> Add new compatible for stm32f469 MCU.
>>>
>>> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>>> b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>>> index 25d9809..4f0487d 100644
>>> --- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>>> +++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.txt
>>> @@ -9,7 +9,8 @@ Pin controller node:
>>>  Required properies:
>>>   - compatible: value should be one of the following:
>>>     (a) "st,stm32f429-pinctrl"
>>> -   (b) "st,stm32f746-pinctrl"
>>> +   (b) "st,stm32f469-pinctrl"
>>> +   (c) "st,stm32f746-pinctrl"
>>
>>
>> Drop the a,b,c. Otherwise, you'll be changing a bunch of lines every
>> time.
>
>
> I completely agree.
>
> Linus, Do i need to send a v2 for this patch ?

Nopes, applied the amended v1 patch already with these
changes, check the result.

Yours,
Linus Walleij
