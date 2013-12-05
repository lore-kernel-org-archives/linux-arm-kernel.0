From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Dec 2013 09:23:57 -0800
Subject: [GIT PULL] at91: cleanup for 3.14 #1 (aka move to CCF)
In-Reply-To: <CAOesGMguxEwWsLeXQH=FTvLToSCJPxSS9w+JQVSfPgi=vD4crw@mail.gmail.com>
References: <1386003701-29760-1-git-send-email-nicolas.ferre@atmel.com>
 <CAOesGMjoK=fN-QCnRS1r2XQFrqc=KN_HPj5A=EVHL3ut58MvQA@mail.gmail.com>
 <52A0AB2E.80504@atmel.com>
 <CAOesGMguxEwWsLeXQH=FTvLToSCJPxSS9w+JQVSfPgi=vD4crw@mail.gmail.com>
Message-ID: <CAOesGMi3gOMd-qSGQfUq4_vbO=pJPgo1mj3LFkJmNzQThTwN6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 9:22 AM, Olof Johansson <olof@lixom.net> wrote:
> On Thu, Dec 5, 2013 at 8:34 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> On 04/12/2013 22:54, Olof Johansson :
>>
>>> On Mon, Dec 2, 2013 at 9:01 AM, Nicolas Ferre <nicolas.ferre@atmel.com>
>>> wrote:
>>>>
>>>> Arnd, Olof, Kevin,
>>>>
>>>> This is the big move of AT91 to Common Clock Framework for 3.14. I
>>>> collected
>>>> all the material as a "cleanup" topic so that the CCF can be considered
>>>> as a
>>>> base for all our AT91 patches for 3.14.
>>>> I prefer to have the sama5d3 use of AT91 CCF included into this
>>>> pull-request
>>>> so that it can be read as an example and clearly states that it has been
>>>> tested
>>>> in real life.
>>>> We agreed with Mike to send this work upstream through arm-soc so that we
>>>> will
>>>> be able to stack other patches for 3.14 on top of that work without
>>>> having to
>>>> deal with conflicts.
>>>>
>>>> For merging with the "fixes" pull-request that I sent earlier today, I
>>>> also
>>>> uploaded a little branch for reference:
>>>> at91-3.14-next_fixes_cleanup_dt-resolution.
>>>> In two words, the clock section of the arch/arm/mach-at91/sama5d3.c file
>>>> has to be deleted.
>>>>
>>>> Do not hesitate to ask questions about this material.
>>>>
>>>> Thanks, best regards,
>>>>
>>>> The following changes since commit
>>>> 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>>>>
>>>>    Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>    git://github.com/at91linux/linux-at91.git tags/at91-cleanup
>>>>
>>>> for you to fetch changes up to b46e837d8ef1f3c777bbf9513e2cdb5d87d6c374:
>>>>
>>>>    ARM: at91/dt: remove old clk material (2013-12-02 15:31:29 +0100)
>>>
>>>
>>> Thanks, pulled into next/cleanup. use this branch as base for your
>>> future at91 branches if you need it to avoid conflicts, please.
>>
>>
>> Yes, sure. I still have to synchronize with Uwe as he is building a series
>> for removing timex.h that may conflict with these modifications.
>>
>>
>>> (I named it at91/sama5-ccf in our tree)
>>
>>
>> Well, it seems that the at91/sama5-ccf is not aligned with
>> next/cleanup as of today (94c5216ee93b)
>>
>> Did I miss something?
>
> Seems that I pulled it into for-next instead of next/cleanup. Thanks
> for catching that.

Sorry, no, what I did was that I accidentally checked out for-next
into at91/sama5-ccf instead of your branch. I did merge the right
thing.


-Olof
