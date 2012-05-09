From: olof@lixom.net (Olof Johansson)
Date: Wed, 9 May 2012 16:47:01 -0700
Subject: [PATCH v9 00/19] Introduce a led trigger for CPU activity and
 consolidate LED driver in ARM
In-Reply-To: <CAK5ve-Ko6EjZsJBW++ofL0eHxiR5W+wafb3T99Rm9a1L8pHLBQ@mail.gmail.com>
References: <1335884506-15370-1-git-send-email-bryan.wu@canonical.com>
 <CAK5ve-KSyvZSHw7csQ5M88q0008NSrs1kwuyUH3hFqxD0f7BQQ@mail.gmail.com>
 <20120509122436.1b612004.akpm@linux-foundation.org>
 <201205092038.16722.arnd.bergmann@linaro.org>
 <CAK5ve-Ko6EjZsJBW++ofL0eHxiR5W+wafb3T99Rm9a1L8pHLBQ@mail.gmail.com>
Message-ID: <CAOesGMhioLshtsYiHCdQxtx7+3GJsCyhgd7c7nDiZC3=3axb6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 4:41 PM, Bryan Wu <bryan.wu@canonical.com> wrote:
> On Thu, May 10, 2012 at 4:38 AM, Arnd Bergmann <arnd.bergmann@linaro.org> wrote:
>> On Wednesday 09 May 2012, Andrew Morton wrote:
>>> I'm the LEDs patchmonkey at present. ?I can merge the drivers/leds
>>> change if you like, but there doesn't seem much point in that unless
>>> all the other patches get merged.
>>>
>>> So my preferred approach would be for the patch series to get merged
>>> via some ARM tree.
>>
>> I'm fine with taking it through arm-soc if that helps.
>
> That would be great to merge from arm-soc tree, thanks a lot, Arnd and Andrew.

Ok, cool. Do you want to stage a branch in a git repo that we pull, or
do you prefer that we pick up the patches as posted? It's easier for
us to just do a pull but either way is fine.



-Olof
