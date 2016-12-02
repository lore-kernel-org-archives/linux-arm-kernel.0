From: m.bielski@virtualopensystems.com (Maciej Bielski)
Date: Fri, 2 Dec 2016 11:55:53 +0100
Subject: [RFC PATCH 0/2] arm64: memory-hotplug: Add Memory Hotplug support
In-Reply-To: <20161202104907.GB8266@arm.com>
References: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
 <18021c70-a4a0-3007-c861-82ede74f965e@virtualopensystems.com>
 <20161202104907.GB8266@arm.com>
Message-ID: <99a1ce87-2dfc-f6f8-353b-70fcd0b3a977@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/12/2016 11:49, Will Deacon wrote:
> On Fri, Dec 02, 2016 at 10:13:43AM +0100, Maciej Bielski wrote:
>> Recently we have announced our effort on that:
>> https://lkml.org/lkml/2016/11/17/49
>>
>> For now we have a working solution for hotplug and we are performing
>> code cleanup to push the patches soon.
> Are these intended to replace or extend Scott's patches? If the former,
> please work with Scott's stuff as a base rather than posting a competing
> series.
In the piece of code provided by Scott I have seen similar steps to what
is done by us but our work went further since we have the mapping
created and everything is working via the sysfs interface. I am now
having closer look and comparing them.
>
> Will

-- 
Maciej Bielski
