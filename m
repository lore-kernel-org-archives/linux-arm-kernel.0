From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 8 Nov 2017 18:14:11 +0000
Subject: [PATCH 1/2] cpuidle: Add new macro to enter a retention idle state
In-Reply-To: <3aa849d6-d456-670b-2c77-a26fa7d597af@codeaurora.org>
References: <1510076133-18139-1-git-send-email-pprakash@codeaurora.org>
 <1510076133-18139-2-git-send-email-pprakash@codeaurora.org>
 <c60a1552-e722-f548-45d4-1529e129c231@arm.com>
 <3aa849d6-d456-670b-2c77-a26fa7d597af@codeaurora.org>
Message-ID: <a3b485e4-fa22-98e4-2b9b-dcb604c89bc2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/11/17 17:15, Prakash, Prashanth wrote:
> Hi Sudeep,
> 
> On 11/8/2017 7:38 AM, Sudeep Holla wrote:

>> I am fine with this change as initial step. But I am wondering if we
>> will have a retention state which loses partial state ?
>>
>> The specification has flags to specify that difference but will we see
>> that in reality is a different question. If we see such hardware, then
>> we may need to revert this and handle in the callbacks as we can't skip
>> cpu_pm notifier callbacks all together right ?
> I agree. This is a initial and quick first step and will help only fully retention states.
> 
> If there are devices with partial retention states and necessary support in cpu
> PM framework we can revert this and handle it in more generic way.
> 

Sounds good. Just wanted to be aware of that fact. Hope we don't get
such crazy hardware(but you never know).

-- 
Regards,
Sudeep
