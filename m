From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Mar 2017 22:14:41 +0900
Subject: [PATCH 1/6] arm64: Use full path in KBUILD_IMAGE definition
In-Reply-To: <ba676afc-d52c-5f79-1794-2b751054bf53@suse.com>
References: <20161122213434.14788-1-mmarek@suse.com>
 <20170310175854.GE18894@arm.com>
 <ba676afc-d52c-5f79-1794-2b751054bf53@suse.com>
Message-ID: <CAK7LNAToohT8a0Xz2Jh53PFcU5e8gCie+ktYhB_j1wzNhRF--A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Michal,

2017-03-11 6:20 GMT+09:00 Michal Marek <mmarek@suse.com>:
> Dne 10.3.2017 v 18:58 Will Deacon napsal(a):
>> Hi Michael,
>>
>> On Tue, Nov 22, 2016 at 10:34:29PM +0100, Michal Marek wrote:
>>> The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
>>> expect it to point to the image file in the build directory. The
>>> builddeb script has a workaround for architectures which only provide
>>> the basename, but let's provide a clean interface for packaging tools.
>>>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Signed-off-by: Michal Marek <mmarek@suse.com>
>>> ---
>>>  arch/arm64/Makefile | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> What's the plan for this patch? I'm happy to merge it,
>
> Great, please merge it.
>
>
>> but I don't see
>> the rest of the series queued anywhere.
>
> I'll see what remains and submit the rest via the kbuild tree.
>
> Thanks,
> Michal
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I like this approach, rather than fixing scripts/package/mkspec.


So, how shall we handle this series?


I am OK with getting 1/6 in through arm64 tree,
but 6/6 will be postponed in the case.



If Will issues Acked-by, I can pick-up the whole series
to linux-kbuild.




-- 
Best Regards
Masahiro Yamada
