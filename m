From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 20 Oct 2011 22:25:15 +0800
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel
	Summit 2011
In-Reply-To: <4EA026C5.1050803@cam.ac.uk>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
	<CACRpkdawG9aKAT7PHuYapiHexkteq-_seQGd6iRORyt-LwbmxA@mail.gmail.com>
	<4EA026C5.1050803@cam.ac.uk>
Message-ID: <CAGsJ_4z+DWSXyn6gN9tOAqY3txM22Hk9jNZFPQ_TuYxT3RsRog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/20 Jonathan Cameron <jic23@cam.ac.uk>:
> On 10/20/11 14:35, Linus Walleij wrote:
>> On Tue, Aug 30, 2011 at 8:00 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>
>>> Nominates, but haven't responded personally:
>>> (...)
>>> 22) Linus Walleji
>>
>> I won't be coming, sorry friends.
>>
>>> Agenda proposals (Thanks to Nicolas and Olof):
>>> - the pin mux subsystem from linusw (especially if it is still RFC by
>>> ?then)
>>
>> I will be happy to attend by wire if provided the necessary details.
>> pin control with mux basics is in -next and I am iterating next design
>> step with Stephen Warren from nVidia.
>>
>>> Still accepting more proposals. ?Send me the topics you are burning to discuss.
>>
>> Since I'm not coming I don't know how relevant my opinions are.
>>
>> But a topic which I think is important is:
>> "Subsystems! Subsystems! Subsystems!"
>> (Bonus if you get Greg to shout this dancing on stage.)
>>
>> We have noticed a lack of subsystems such as pin control to
>> compartmentalize "stuff" currently stacking up in arch/arm/*
>> drivers/misc/* and drivers/mfd/*.
>>
>> The problem of how to adress this the proper way by creating
>> new subsystems need to be shed some light upon, just telling
>> every subarch to "go create a new subsystem, it'll just take a
>> few man-years of your working hours" apparently does not always
>> work.
>>
>> On a related key is the need to get the stuff in drivers/staging/iio
>> into drivers/ proper.
> Thanks Linus. ?What this needs is a few of those man hours of people ripping
> the proposed patches to shreds. Lots more to follow once step one is cleaned
> up :)

as Jonathan knows, i was one of main authors of those drivers in
drivers/staging/iio. one problem for iio is now most people still
write sensor drivers based on input subsystem or others but not iio.
and Android HAL or other frameworks prefer input _event as well.
so to push iio ahead, we might push related app ahead too.

>>
>> Just my ?0.01..
>>
>> BR,
>> Linus Walleij

-barry
