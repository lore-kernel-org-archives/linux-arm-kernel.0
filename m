From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 16 Feb 2016 10:58:20 -0300
Subject: [PATCH] ARM: dts: Move syscon reboot/poweroff to common dtsi for
 Exynos
In-Reply-To: <56C25982.4020301@samsung.com>
References: <1455042606-10075-1-git-send-email-javier@osg.samsung.com>
 <56C02265.40103@samsung.com> <56C1D4D1.2050108@osg.samsung.com>
 <56C25982.4020301@samsung.com>
Message-ID: <56C32AFC.6030905@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 02/15/2016 08:04 PM, Krzysztof Kozlowski wrote:
> On 15.02.2016 22:38, Javier Martinez Canillas wrote:
>>>
>>> In some of the DTSI this was under "soc" node, not at top-level.
>>> Unfortunately we do not have consistency here - some DTSI have "soc",
>>
>> Yes, I noticed this but as you said not all DTSI have a soc node
>> and that's why I made it top level in the DTSI.
>>
>>> some not. Anyway I think we should move to "soc" version.
>>>
>>
>> Not sure I'm following, did you mean to do it as a follow up or
>> to add a soc node for the missing DTSI as a part of this series?
>
> I meant to send a v2 with this under "soc" node even though on some DTS
> we do not have the "soc". Optional follow up would be to make DTS
> consistent and move nodes under "soc"... but that would be also a lot of
> churn.
>

Thanks for the clarification. I'll post a v2 then moving under a soc node.
  
> Best regards,
> Krzysztof

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
