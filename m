From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Dec 2011 18:10:25 -0800
Subject: [GIT PULL] omap1 changes for v3.3 merge window
In-Reply-To: <20111209213727.GC31337@atomide.com>
References: <20111209212804.GA31337@atomide.com>
 <20111209213727.GC31337@atomide.com>
Message-ID: <CAOesGMg5SP2tJN6KkgYYUqY-QuUtXuZD0VAaxqnA+mThS9f8aA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 1:37 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [111209 12:56]:
>> Hi And & Olof,
>>
>> Please pull omap1 changes from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap1
>>
>> These changes are necessary to always reprogram the core clock
>> based on the SoC type so we can boot at the fastest supported rate.
>
> Sorry forgot to mention that this has a dependency to the fixes that
> you pulled in yesterday.

Thanks for the heads up. Pulled into next/devel.


-Olof
