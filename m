From: olof@lixom.net (Olof Johansson)
Date: Fri, 21 Aug 2015 16:32:47 -0700
Subject: [GIT PULL] RPi DT changes due for v4.3
In-Reply-To: <55D7B3DB.8070405@gmail.com>
References: <20150811160642.GQ18282@x1> <20150813103056.GY30160@localhost>
 <55D7B3DB.8070405@gmail.com>
Message-ID: <CAOesGMjpR01rLHpj5ZSJq6eze4wU8KDS3wBmZdqKOAJmH0U5UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 21, 2015 at 4:27 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 13/08/15 03:30, Olof Johansson wrote:
>> Hi,
>>
>> On Tue, Aug 11, 2015 at 05:06:42PM +0100, Lee Jones wrote:
>>> ARM SoC Chaps,
>>>
>>> Please find a couple of simple RPi changes pertaining to Firmware.
>>>
>>> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
>>>
>>>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git tags/rpi-dt-for-armsoc-4.3
>>>
>>> for you to fetch changes up to fd26f8830979de48eb3f1c253eb9d2ee2e468eb6:
>>>
>>>   dt/bindings: Add binding for the Raspberry Pi firmware driver (2015-08-11 16:56:41 +0100)
>>
>> I've merged this but I'm a little confused about bcm2835 maintainership:
>> I got a MAINTAINERS update from Florian earlier grouped in a set of
>> other bcm changes (adding Eric), and now this directly from you.
>>
>> In general the bcm platforms are quite diverse and we've asked Florian
>> to be the funnel for all of the new ones, but I don't think we talked
>> much about 2835 at that time. Should we expect to see merges directly
>> from you and the other maintainers there or will it go through Florian?
>>
>> Either way is OK with me, just looking to clarify.
>
> Could you merge this pull request directly? Eric and I met recently and
> we agreed on a more formal process for the next submissions which will
> be having me route the RPi changes through the Broadcom pull requests.

Yeah, as I said above I merged it already, I was just looking for clarification.

Merging through you sounds like a good way forward, and keeps the brcm
platforms consistent.


Thanks!

-Olof
