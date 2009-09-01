From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 1 Sep 2009 22:34:14 +0800
Subject: My first patch to the mailist, but being held
In-Reply-To: <e68bb3470909010725n4ddc05c4k3534f1e8661dfa23@mail.gmail.com>
References: <e68bb3470909010616n74326317s49c27e8c8cbcbc4a@mail.gmail.com>
	<f17812d70909010655t139a10d1y7b421cd244d91737@mail.gmail.com>
	<e68bb3470909010705v2219191dtce02f6bfc29d9647@mail.gmail.com>
	<1251814118.16594.292.camel@macbook.infradead.org>
	<e68bb3470909010725n4ddc05c4k3534f1e8661dfa23@mail.gmail.com>
Message-ID: <f17812d70909010734h5c6420e1jc881b59528deda79@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 1, 2009 at 10:25 PM, Wan ZongShun<mcuos.com@gmail.com> wrote:
> Dear David,
>
> 2009/9/1 David Woodhouse <dwmw2@infradead.org>:
>> On Tue, 2009-09-01 at 22:05 +0800, Wan ZongShun wrote:
>>>
>>> Yes, I think so too, due to I never meet this type 'held' in LAKML and
>>> LKML, so I am amazed at this 'held' in the list.
>>
>> Not all of the mailman settings were imported from the old list to the
>> new one. If the moderators want to increase the size limit, they are
>> free to do that -- the hardware can certainly cope.
>>
>> But Eric is right that patches above 40KiB are fairly suspect anyway --
>> why is it so large?
>
> The patch is one of the series patches of changing my w90x900 platform
> architecture, originally, I submitted nine patches to mend my
> platform, Russell has reviewed them and
> hoped me to re-arrange the patches, so I Integrated the nine patches
> into three ones.
>
> I just ignore the size of patch issue.
>

You can try 'git format-patch -M' to shrink the size of the patch significantly
if renaming is involved.
