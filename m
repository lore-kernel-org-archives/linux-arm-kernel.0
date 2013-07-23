From: olof@lixom.net (Olof Johansson)
Date: Tue, 23 Jul 2013 16:56:09 -0700
Subject: [GIT PULL] Remove ARM local timer API
In-Reply-To: <20130723234040.GB27761@codeaurora.org>
References: <20130625200211.GA11625@codeaurora.org>
 <CAOesGMj5AZcB7-kcS8_JqfKAg_RUKqTdDZf7bdwkebn3pwADAw@mail.gmail.com>
 <20130723234040.GB27761@codeaurora.org>
Message-ID: <CAOesGMiornt0twdQv=tYMtAX56Lc79MVyNrHaK1nWpOk189dDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 4:40 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 07/23, Olof Johansson wrote:

>> Merged in as localtimer/removal into next/cleanup.
>>
>> I had quite a few merge conflicts due to the __cpuinit removal, so
>> please double-check my resolutions.
>>
>
> A __cpuinit is leftover in smp_twd.c. Hopefully you can just
> redo the merge?

Done, thanks for catching it. I thought I grepped for them but I
somehow missed that one. Fixed now.


-Olof
