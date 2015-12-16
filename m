From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Wed, 16 Dec 2015 09:55:39 -0300
Subject: [PATCH 2/3] ARM: dts: lpc4337-ciaa: enable SCT-PWM
In-Reply-To: <CAGhQ9Vxqpe4QQn1+d6bOCQH9q6evignVR_+U4NK7HqSNhBg4qA@mail.gmail.com>
References: <1448282225-2635-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1448282225-2635-3-git-send-email-ariel@vanguardiasur.com.ar>
 <5655A977.1040408@vanguardiasur.com.ar>
 <CAGhQ9Vxqpe4QQn1+d6bOCQH9q6evignVR_+U4NK7HqSNhBg4qA@mail.gmail.com>
Message-ID: <56715F4B.7050109@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joachim,

El 14/12/15 a las 19:48, Joachim Eastwood escribi?:
> Hi Ariel,
> 
> Sorry for the late reply. I have just started to put together my DT
> for 4.5 branch now.
> 
> On 25 November 2015 at 13:28, Ariel D'Alessandro
> <ariel@vanguardiasur.com.ar> wrote:
>> (+To: Joachim)
>>
>> El 23/11/15 a las 09:37, Ariel D'Alessandro escribi?:
>>> Enable the PWM based on the State Configurable Timer (SCT) included in
>>> the LPC4337 SoC of the CIAA-NXP board.
>>>
>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>> ---
>>>  arch/arm/boot/dts/lpc4337-ciaa.dts | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
>>> index 03bdf77..1a23589 100644
>>> --- a/arch/arm/boot/dts/lpc4337-ciaa.dts
>>> +++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
>>> @@ -170,6 +170,10 @@
>>>       pinctrl-0 = <&enet_rmii_pins>;
>>>  };
>>>
>>> +&sct_pwm {
>>> +     status = "okay";
>>> +};
>>> +
> 
> Isn't this a bit useless without any pinmux setup?

Yes, it might be kind of useless. Do you think it shouldn't be enabled then?

-- 
Ariel D'Alessandro, VanguardiaSur
www.vanguardiasur.com.ar
