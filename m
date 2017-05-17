From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 17 May 2017 16:27:44 +0100
Subject: [PATCH 1/3] arm64: hugetlb: Fix huge_pte_offset to return
 poisoned page table entries
In-Reply-To: <CAOZdJXVrMSUkHcsJXg+qdA=Bxt0bT5Dn5-MCUvZdSv8_8XaU-Q@mail.gmail.com>
 (Timur Tabi's message of "Wed, 17 May 2017 09:35:22 -0500")
References: <20170412140459.21824-1-punit.agrawal@arm.com>
 <20170412140459.21824-2-punit.agrawal@arm.com>
 <20170503124906.GA5622@e104818-lin.cambridge.arm.com>
 <87lgqcy5uw.fsf@e105922-lin.cambridge.arm.com>
 <CAOZdJXVrMSUkHcsJXg+qdA=Bxt0bT5Dn5-MCUvZdSv8_8XaU-Q@mail.gmail.com>
Message-ID: <87tw4jlczz.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timur Tabi <timur@codeaurora.org> writes:

> On Thu, May 4, 2017 at 10:55 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
>> Indeed - I was avoiding changing the function to drop contiguous
>> hugepage support which follows this hunk.
>>
>> I've made changes locally based on your suggestion and will post a
>> revised version after the merge window.
>
> Punit, will you be able to post a new version that could be a
> candidate for 4.13?

Hi Timur,

I've just posted v2 for this series. I was testing the patches on rc1
when I saw your mail come through.

Please shout out if you notice any problems with the new version.

Thanks,
Punit
