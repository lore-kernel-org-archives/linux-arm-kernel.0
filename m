From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 19:52:44 -0600
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <50491F65.2020302@simon.arlott.org.uk>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <CAG-w=x77y6ykh3FcyTtVAN85eOk1RP2CZ=ZG-_1091i5jYDF2A@mail.gmail.com>
 <50491F65.2020302@simon.arlott.org.uk>
Message-ID: <5049536C.7050300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 04:10 PM, Simon Arlott wrote:
> On 06/09/12 17:53, Seth Jennings wrote:
>> (sorry for the dup Stephen, forgot to reply all :-/)
>>
>> On Thu, Sep 6, 2012 at 12:07 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>
>>> The BCM2708 is an ARM SoC from Broadcom. It is the primary SoC in a
>>> series which contains the BCM2835 amongst other variants. This patch
>>> adds very basic support for this series of SoCs, under the BCM2708 name.
>>
>> Great work! I'm glad to see this heading upstream :)
>>
>>> This series was extracted from git://github.com/lp0/linux.git branch
>>> rpi-next or rpi-linear from 3-4 months ago, and significantly stripped
>>> down and modified since.
> 
> I don't know why you're using the rpi-linear branch when the rpi-split
> branch has the same content but everything already split into separate
> patches...

Honestly, I extracted most of this patch about 3 months ago, and don't
remember exactly which of the branches it was based on. Looking at
rpi-split, the code could just as well have come from there, so I'll
reword the commit description to mention that branch instead.
