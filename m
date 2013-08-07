From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 06 Aug 2013 17:06:03 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Interested in R/M-class
 (!MMU), automated testing
In-Reply-To: <20130806234419.GC15014@blackmetal.musicnaut.iki.fi>
References: <51FBF93D.8040707@arm.com> <20130804122527.GV3880@pengutronix.de>
 <CAOesGMgnYLXRWRtKckofNpsxmRgT0cXL=JcAMirXibe92+AWOQ@mail.gmail.com>
 <20130806234419.GC15014@blackmetal.musicnaut.iki.fi>
Message-ID: <52018F6B.1090404@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2013 04:44 PM, Aaro Koskinen wrote:
> On Sun, Aug 04, 2013 at 11:49:03PM -0700, Olof Johansson wrote:
>> On Sun, Aug 4, 2013 at 5:25 AM, Robert Schwebel
>> <r.schwebel@pengutronix.de> wrote:
>>
>>>> - Ways to do more automated testing of ARM kernels, including hearing
>>>>    from other people what they use to build/boot/test/benchmark their
>>>>    code (perhaps even get a discussion going about using the diverse
>>>>    range of hardware people have around put to use as test-machines).
>>>
>>> That's pretty interesting; we have a test farm at PTX, but it mainly
>>> does nightly build + boot tests on mainline, for systems we care of.
>>
>> I have a small (but growing) farm of boards here that I do some (so
>> far) limited boot testing, but I do it a few times a day on mainline,
>> and nightly on linux-next and arm-soc for-next branches.
>
> How successful is your testing? Any statistics how many pull requests
> or patches you can shoot down or revert (or ask to be redone) before
> they hit mainline?
>

Someone told me that the Yocto project starts implementing automated tests.
Wonder if those are done for arm targets as well. Either case, if anyone has
experience running basic arm tests on qemu I would be interested to know -
it is on my task list for automated testing on the -stable queue.

Guenter
