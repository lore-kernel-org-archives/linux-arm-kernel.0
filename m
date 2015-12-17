From: manabian@gmail.com (Joachim Eastwood)
Date: Thu, 17 Dec 2015 23:55:23 +0100
Subject: [PATCH 2/3] ARM: dts: lpc4337-ciaa: enable SCT-PWM
In-Reply-To: <56715F4B.7050109@vanguardiasur.com.ar>
References: <1448282225-2635-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1448282225-2635-3-git-send-email-ariel@vanguardiasur.com.ar>
 <5655A977.1040408@vanguardiasur.com.ar>
 <CAGhQ9Vxqpe4QQn1+d6bOCQH9q6evignVR_+U4NK7HqSNhBg4qA@mail.gmail.com>
 <56715F4B.7050109@vanguardiasur.com.ar>
Message-ID: <CAGhQ9Vzt6b3Bgcc6yoroQyDtbsw=QeDWRQCKKNdJ3ObCGWUfnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 December 2015 at 13:55, Ariel D'Alessandro
<ariel@vanguardiasur.com.ar> wrote:
> Joachim,
>
> El 14/12/15 a las 19:48, Joachim Eastwood escribi?:
>> Hi Ariel,
>>
>> Sorry for the late reply. I have just started to put together my DT
>> for 4.5 branch now.
>>
>> On 25 November 2015 at 13:28, Ariel D'Alessandro
>> <ariel@vanguardiasur.com.ar> wrote:
>>> (+To: Joachim)
>>>
>>> El 23/11/15 a las 09:37, Ariel D'Alessandro escribi?:
>>>> Enable the PWM based on the State Configurable Timer (SCT) included in
>>>> the LPC4337 SoC of the CIAA-NXP board.
>>>>
>>>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>>>> ---
>>>>  arch/arm/boot/dts/lpc4337-ciaa.dts | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
>>>> index 03bdf77..1a23589 100644
>>>> --- a/arch/arm/boot/dts/lpc4337-ciaa.dts
>>>> +++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
>>>> @@ -170,6 +170,10 @@
>>>>       pinctrl-0 = <&enet_rmii_pins>;
>>>>  };
>>>>
>>>> +&sct_pwm {
>>>> +     status = "okay";
>>>> +};
>>>> +
>>
>> Isn't this a bit useless without any pinmux setup?
>
> Yes, it might be kind of useless. Do you think it shouldn't be enabled then?

It would be nice to have a board with sct-pwm enabled. Would it
possible for you to assign a pin to it?


regards,
Joachim Eastwood
