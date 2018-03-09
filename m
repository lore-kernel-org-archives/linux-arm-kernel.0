From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Fri, 9 Mar 2018 15:47:01 -0800
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <OF08D8261E.8F72E5DC-ON0025824B.008218BB-0025824B.008218C6@notes.na.collabserv.com>
References: <20180307221124.GD10438@amd>
 <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
 <OF08D8261E.8F72E5DC-ON0025824B.008218BB-0025824B.008218C6@notes.na.collabserv.com>
Message-ID: <ed44999b-c877-463e-3a20-415faaab31b2@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milton,

Thanks for sharing your time to review this patch. Please see my answer 
inline.

Jae

On 3/9/2018 3:41 PM, Milton Miller II wrote:
> About  03/07/2018 04:12PM in some time zone, Pavel Machek wrote:
>> Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings:
>> Add a document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
>>
>> Hi!
>>
>>>> Are these SoCs x86-based?
>>>
>>> Yes, these are ARM SoCs. Please see Andrew's answer as well.
>>
>> Understood, thanks.
>>
>>>>> +	Read sampling point selection. The whole period of a bit time
>> will be
>>>>> +	divided into 16 time frames. This value will determine which
>> time frame
>>>>> +	this controller will sample PECI signal for data read back.
>> Usually in
>>>>> +	the middle of a bit time is the best.
>>>>
>>>> English? "This value will determine when this controller"?
>>>>
>>>
>>> Could I change it like below?:
>>>
>>> "This value will determine in which time frame this controller
>> samples PECI
>>> signal for data read back"
>>
>> I guess... I'm not native speaker, I guess this could be improved
>> some
>> more.
>>
> 
> I agree this wording is still confusing.
> 
> The problem is that the key subject, the time of the sampling, is in the descriptive clause "in which time frame".
> 
> "This value will determine the time frame in which the controller will sample"
> 
> or perhaps phrase it as saving a specific sample from the over-clock, or a phase of the clock.
> 

Yes, that looks more better. I'll change the wording as you suggested. 
Thanks a lot!

Jae

>> Best regards,
>> 									Pavel
>>
>> -- 
>> (english) http://www.livejournal.com/~pavelmachek
>> (cesky, pictures)
>> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>>
> 
> milton
> --
> Speaking for myself not IBM.
> 
