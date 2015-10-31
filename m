From: icoolidge@google.com (Ian Coolidge)
Date: Sat, 31 Oct 2015 12:49:46 -0700
Subject: [PATCH] arm: spinlock: const qualify read-only functions.
In-Reply-To: <CAB3A_j_AHrvp213D5sqSnXWvo12NWWCEpv3AEYxT0dNsWh_mog@mail.gmail.com>
References: <1446061495-38554-1-git-send-email-icoolidge@google.com>
 <1446164820-16144-1-git-send-email-icoolidge@google.com>
 <CAB3A_j9VhARfgybw-oQWVdZciSdc93i1fEL7tTdRHvdzUtQkog@mail.gmail.com>
 <CAKv+Gu8ksbi=j=jhv2P=4dNHWY_6B+i5=LCbwrLv1TsJGNY9gA@mail.gmail.com>
 <CAB3A_j_AHrvp213D5sqSnXWvo12NWWCEpv3AEYxT0dNsWh_mog@mail.gmail.com>
Message-ID: <CAB3A_j8RmbCiOYfZROKh9_M9dRDhyjO-h_HTyLaamSWvHVpVNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2015 at 12:46 PM, Ian Coolidge <icoolidge@google.com> wrote:
> Hi Ard,
>
> :) D'oh, yes, I had assumed you were the same person.
>
> It is for a driver that I would eventually like to upstream.
>
> I see that there are many cases where assert_spin_lock is used, but
> perhaps driver developers are underutilizing const,
> or compiling the kernel with warnings tolerated.
>
>> Note that Ard (me) and Arnd are two different persons.
>>
>> I think your patch makes sense in itself, I just wonder if there are
>> any real examples in the current codebase that would require it. Which
>> struct is it that you are looking to constify, and in which context?
>>
>> Regards,
>> Ard.

Sorry for the top-post, and I meant 'assert_spin_locked'.
