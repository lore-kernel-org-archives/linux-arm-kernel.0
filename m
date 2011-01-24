From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Jan 2011 13:30:55 -0800
Subject: [PATCH v2 07/11] msm: Add MSM 8960 cpu_is check
In-Reply-To: <1295901976.29639.53.camel@c-dwalke-linux.qualcomm.com> (Daniel
	Walker's message of "Mon, 24 Jan 2011 12:46:16 -0800")
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-8-git-send-email-davidb@codeaurora.org>
	<1295901976.29639.53.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <8yak4hukn00.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24 2011, Daniel Walker wrote:

> On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
>> diff --git a/arch/arm/mach-msm/include/mach/cpu.h
>> b/arch/arm/mach-msm/include/mach/cpu.h
>> index e1ba9db..a9481b0 100644
>> --- a/arch/arm/mach-msm/include/mach/cpu.h
>> +++ b/arch/arm/mach-msm/include/mach/cpu.h
>> @@ -24,6 +24,7 @@
>>  #define cpu_is_msm7x30()       0
>>  #define cpu_is_qsd8x50()       0
>>  #define cpu_is_msm8x60()       0
>> +#define cpu_is_msm8960()       0
>
> The naming is just perverted even more here..

What do you want me to call it?

  #define cpu_is_97d0c886-3768-4998-8925-16f36209d0d1()

It's the name of the chip.  We've already been through this.  The names
are unfortunate, but it is what the devices are called.

At some point, I may change the msm8x60 to something more specific, such
as msm8260, or msm8660, one of the devices that it represents.  But this
isn't correct, either.  There really isn't a good answer.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
