From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 13 Nov 2009 11:48:41 +0800
Subject: pxafb: RGBT555 support
In-Reply-To: <200911121149.35771.pieterg@gmx.com>
References: <200910291235.55826.pieterg@gmx.com>
	<f17812d70911040633k27863332seaf29184ff38e7e7@mail.gmail.com>
	<200911051727.03171.pieterg@gmx.com>
	<200911121149.35771.pieterg@gmx.com>
Message-ID: <f17812d70911121948p7e819bf3x9a43e5edccbcb3e9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 6:49 PM, pieterg <pieterg@gmx.com> wrote:
> On Thursday 05 November 2009 17:27:02 pieterg wrote:
>> On Wednesday 04 November 2009 15:33:21 Eric Miao wrote:
>> > >> Unfortunately, transparency is part of depth and it's really not
>> > >> easy to distinguish between RGB565 and RGBT555 by depth and
>> > >> bits_per_pixel only without introducing something else.
>> > >
>> > > So perhaps something like this (untested)?
>> >
>> > This looks good to me - please have this tested and I'll merge it
>> > later if no other comments.
>>
>> Tested, and it works.
>> Please use this version instead of the original one I posted, no matter
>> how small it is, I still managed to get a typo in ;)
>
> Just for my information (and as a reminder perhaps), is this patch going to
> make it?
>

Pieter,

You need to Signoff your patch before I can merge it, please see
linux/Documentation/SubmittingPatches.

Thanks
- eric
