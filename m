From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 2 Dec 2016 09:40:04 -0800
Subject: [RFC PATCH 0/2] arm64: memory-hotplug: Add Memory Hotplug support
In-Reply-To: <99a1ce87-2dfc-f6f8-353b-70fcd0b3a977@virtualopensystems.com>
References: <1480637999-4320-1-git-send-email-scott.branden@broadcom.com>
 <18021c70-a4a0-3007-c861-82ede74f965e@virtualopensystems.com>
 <20161202104907.GB8266@arm.com>
 <99a1ce87-2dfc-f6f8-353b-70fcd0b3a977@virtualopensystems.com>
Message-ID: <546cf066-6351-8357-2388-73420ec063ec@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

On 16-12-02 02:55 AM, Maciej Bielski wrote:
>
>
> On 02/12/2016 11:49, Will Deacon wrote:
>> On Fri, Dec 02, 2016 at 10:13:43AM +0100, Maciej Bielski wrote:
>>> Recently we have announced our effort on that:
>>> https://lkml.org/lkml/2016/11/17/49
>>>
>>> For now we have a working solution for hotplug and we are performing
>>> code cleanup to push the patches soon.
>> Are these intended to replace or extend Scott's patches? If the former,
>> please work with Scott's stuff as a base rather than posting a competing
>> series.
> In the piece of code provided by Scott I have seen similar steps to what
> is done by us but our work went further since we have the mapping
> created and everything is working via the sysfs interface. I am now
> having closer look and comparing them.

I would love to see the missing section mapping step and any other 
additions to test out.  Please send additions as soon as you have a chance.

Regards,
  Scott

>>
>> Will
>
