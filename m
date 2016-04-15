From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 15 Apr 2016 09:52:20 +0100
Subject: [PATCH v5 00/10] Support for Cortex-M Prototyping System
In-Reply-To: <20160414192540.GD20512@kroah.com>
References: <1459519381-34441-1-git-send-email-vladimir.murzin@arm.com>
 <570F593D.6040809@arm.com> <20160414192540.GD20512@kroah.com>
Message-ID: <5710ABC4.5070505@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 14/04/16 20:25, Greg KH wrote:
> On Thu, Apr 14, 2016 at 09:47:57AM +0100, Vladimir Murzin wrote:
>> Hi,
>>
>> On 01/04/16 15:02, Vladimir Murzin wrote:
>>> Hi,
>>>
>>> This patch series provides the basic support for running ucLinux on V2M-MPS2
>>> platform.
>>>
>>> With these patches applied ucLinux can be run on both HW and FVP models
>>> with Cortex-M3/M4/M7 configurations.
>>
>> Any objection to get it merged?
>>
>> Sudeep Holla noticed that there is merge conflict against linux-next
>> with PIC32 uart (Makefile and serial_core.h), so should I provide
>> conflict resolution or do rebase on someone's branch?
>>
>> Anyway, I'd be glad to know how it should be processed further?
>
> I have no objection to the tty/serial changes, so if this all goes
> through the arm-soc tree, that's fine with me.
>

Thanks Greg, can I take this as Ack ? arm-soc guys might expect to see
that tag :)

Hi Vladimir,

I have pulled this series into
git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git 
for-next/armv7-vexpress-updates

I will stick Greg's tag when it comes.

-- 
Regards,
Sudeep
