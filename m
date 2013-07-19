From: olof@lixom.net (Olof Johansson)
Date: Fri, 19 Jul 2013 09:24:35 +0200
Subject: [GIT PULL] Remove ARM local timer API
In-Reply-To: <51E71202.5060207@codeaurora.org>
References: <20130625200211.GA11625@codeaurora.org>
 <20130628000853.GB11547@quad.lixom.net> <20130708153528.GB830@codeaurora.org>
 <51E71202.5060207@codeaurora.org>
Message-ID: <40771222-cc0f-4826-b14f-8dcdb4abb673@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Stephen Boyd <sboyd@codeaurora.org> wrote:

>On 07/08/13 08:35, Stephen Boyd wrote:
>> On 06/27, Olof Johansson wrote:
>>> On Tue, Jun 25, 2013 at 01:02:12PM -0700, Stephen Boyd wrote:
>>>> Olof/Arnd,
>>>>
>>>> These patches remove the ARM local timer API. The ARM architected
>>>> timers have already moved away from this API so this series
>>>> migrates the rest of the users allowing us to remove the API
>>>> entirely. Thomas has been kind enough to take the first two
>>>> patches into timers/core in the tip tree (thanks Thomas!) so I've
>>>> merged that into v3.10-rc1 and then applied the rest of the
>>>> patches on top. Let me know if this is acceptable.
>>> We need guarantees from Thomas that the branch is stable and will
>never be
>>> rebased before it hit Linus tree, or we'll be in a world of pain for
>>> dependencies like these.
>>>
>>> Thomas, is this branch stable or do you anticipate a rebase?
>>>
>> This branch has merged into Linus' tree. Can this go through the
>> arm-soc tree now?
>>
>
>The merge window is over now. Can this be merged for 3.12?

Yes, I am still traveling and haven't done any merges for 3.12 yet. This is first in the queue, I should get to it over the weekend or early next week.


-Olof
