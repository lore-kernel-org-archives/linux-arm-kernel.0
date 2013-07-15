From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 15 Jul 2013 11:26:09 +0100
Subject: v3.10 - big endian core support
In-Reply-To: <20130715103658.068ac6b7@skate>
References: <CALicx6u89THSiRa4FzGZrcoG8q+o_BD8qVEC4CYXEjPUVK_fJw@mail.gmail.com>
 <20130712134726.0a909165@skate> <51DFEF75.8080600@codethink.co.uk>
 <20130714215325.GB7382@mudshark.cambridge.arm.com>
 <51E3ACD0.8040209@codethink.co.uk> <20130715103658.068ac6b7@skate>
Message-ID: <51E3CE41.5010807@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/07/13 09:36, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Mon, 15 Jul 2013 09:03:28 +0100, Ben Dooks wrote:
>
>>> As for building a Thumb-2 kernel; just enable the option in menuconfig and
>>> you're done. The compiler should "do the right thing".
>>
>> I can build it, I just don't have the time and hardware to give it a
>> test at the moment. However it seems that changing to using 'rev16'
>> instead of 'rev'. I will make the necessary changes and get this ready
>> to go.
>
> I am willing to give some testing to early patches, if needed. Do not
> hesitate to send me things to test.

I've pushed out two new branches on git.baserock.org/delta/linux.git
as:
	baserock/311/be/core-v2
	baserock/311/be/atags-v2

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
