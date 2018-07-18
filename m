From: olof@lixom.net (Olof Johansson)
Date: Wed, 18 Jul 2018 07:59:25 -0700
Subject: [GIT PULL] pxa for v4.19-v2
In-Reply-To: <59475364-3050-d5c3-e3df-a750c3cb6bc0@zonque.org>
References: <871sc37xrs.fsf@belgarion.home>
 <CAOesGMizEXbF5VUCshamVuVSkLQd7274m3zGWwZ3E3ULxoomEw@mail.gmail.com>
 <59475364-3050-d5c3-e3df-a750c3cb6bc0@zonque.org>
Message-ID: <CAOesGMgnwn5bzGY2y3-xiJitamBf=V8jmbTuq7uAFTSE_oEnkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 7:56 AM, Daniel Mack <daniel@zonque.org> wrote:
> On Wednesday, July 18, 2018 04:55 PM, Olof Johansson wrote:
>>
>> On Mon, Jul 16, 2018 at 1:04 PM, Robert Jarzmik <robert.jarzmik@free.fr>
>> wrote:
>>>
>>> Hi Arnd, Kevin, and Olof,
>>>
>>> This is the pxa pull request for 4.19 v2. It is the same pull request as
>>> v1,
>>> with one patch removed and postponed for 4.20 to fix cross trees
>>> dependencies
>>> breakage.
>>>
>>> As before, this time it touches a lot of subsystems because of the dma
>>> slave map
>>> conversion of the pxa architecture.
>>>
>>> Can you please consider pulling ?
>>>
>>> The following changes since commit
>>> ce397d215ccd07b8ae3f71db689aedb85d56ab40:
>>>
>>>    Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
>>>
>>> are available in the git repository at:
>>>
>>>    https://github.com/rjarzmik/linux.git tags/pxa-for-4.19-v2
>>>
>>> for you to fetch changes up to cbc654c88178b7dc3b63f57278cb917ffdb629cc:
>>>
>>>    net: smc91x: remove the dmaengine compat need (2018-06-21 10:45:47
>>> +0200)
>>>
>>> ----------------------------------------------------------------
>>> This is the pxa changes for 4.19 cycle :
>>>   - the pxa architecture is ported to dma slavemap
>>>   - some minor AC97 fixes
>>>   - some minor board fixes
>>
>>
>> Thanks -- I merged just into our for-next yesterday to get one run
>> through linux-next overnight, and that looked good. So I now merged it
>> into next/soc as well.
>
>
> Thanks! Can we get that missing patch merged in 4.19-rc2 maybe? I'd much
> like to finally get this transition off the table for the 4.19 release :)

Probably, but let's see what fallout is like during the merge window
and decide then, send it right after -rc1 if that's the case (a patch
is fine, no need to do a pull request).


-Olof
