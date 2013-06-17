From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 17 Jun 2013 10:42:17 +0530
Subject: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
In-Reply-To: <79CD15C6BA57404B839C016229A409A83ECB9CD9@DBDE04.ent.ti.com>
References: <1371118124-15910-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.02.1306140243380.5514@utopia.booyaka.com>
 <8738skaj16.fsf@linaro.org>
 <79CD15C6BA57404B839C016229A409A83ECB9CD9@DBDE04.ent.ti.com>
Message-ID: <51BE9AB1.2080308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013 10:38 AM, Hiremath, Vaibhav wrote:
> 
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
>> owner at vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Friday, June 14, 2013 7:31 PM
>> To: Paul Walmsley
>> Cc: Nayak, Rajendra; Hiremath, Vaibhav; linux-omap at vger.kernel.org;
>> linux-arm-kernel at lists.infradead.org
>> Subject: Re: [PATCH 0/2] Remove unused voltagedomain data for AM33xx
>>
>> Paul Walmsley <paul@pwsan.com> writes:
>>
>>> cc Kevin, Vaibhav
>>>
>>> On Thu, 13 Jun 2013, Rajendra Nayak wrote:
>>>
>>>> The powerdomain framework today expects to always have a
>> voltagedomain
>>>> associated with a given powerdomain. We already have AM33xx which
>>>> has no Voltage Controller/Voltage Processor as part of PRCM.
>>>> There are more SoCs' to follow starting with AM437x and DRA7xx
>>>> which do not have VC/VP.
>>>>
>>>> Instead of adding dummy voltage domain data files, make the
>> powerdomain
>>>> framework aware of the fact that some SoCs' might not really have
>>>> scalable voltage domains.
>>>
>>> Fine with me in principle if AM335x doesn't support voltage scaling.
>>> Vaibhav, if this is okay for you, please ack it.
>>>
>>> Then, in terms of merging, probably Kevin would be the right person
>> for
>>> this since he's done much of the voltagedomain work.
>>
>> Yeah, I'll take this series after the minor issues I commented on are
>> fixed, and Vaivhav ack's the AM33xx parts.
>>
> 
> Yeup, Feel free to add my Ack here.

Thanks Vaibhav, I will add your and Nishanths' ack for this series
and repost a v2 addressing Kevins comments.

regards,
Rajendra
> 
> 
> Thanks,
> Vaibhav 
> 
