From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 15 Apr 2014 17:51:15 +0900
Subject: [PATCHv2 3/8] ARM: EXYNOS: Add IO mapping for PMU of Exynos3250
In-Reply-To: <5677551.At1Foxml9e@wuerfel>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <4788081.xvaJfdGTMu@wuerfel> <534CEEA8.6020800@samsung.com>
 <5677551.At1Foxml9e@wuerfel>
Message-ID: <534CF303.6050100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 05:46 PM, Arnd Bergmann wrote:
> On Tuesday 15 April 2014 17:32:40 Chanwoo Choi wrote:
>> On 04/15/2014 05:11 PM, Arnd Bergmann wrote:
>>> On Tuesday 15 April 2014 10:59:47 Chanwoo Choi wrote:
>>
>>> I don't think we have a patch for the PMU yet, Sachin was looking at the SYSRAM
>>> only.
>>
>> You are right. Sachin's patch only included the solution of SYSRAM memory mapping.
>> I set out the plan that I would implment proper driver for PMU memory mapping
>> instead of static method after merged Sachin's patch for SYSRAM.
>>
>> But,
>> If you'd like me to implment PMU memory mapping instead of static mapping right now,
>> I'll implement it for PMU such as Sachin's patch on next posting(v3).
> 
> I don't really want to merge a new SoC type until these are resolved, so
> it would definitely be better to implement this for v3.
> 

OK,
I'll rebase this patch on following patch which support PMU memory mapping through DT.

[1] http://www.spinics.net/lists/arm-kernel/msg316013.html

Thanks for your review.

Best Regards,
Chanwoo Choi
