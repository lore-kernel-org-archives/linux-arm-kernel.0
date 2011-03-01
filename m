From: khilman@ti.com (Kevin Hilman)
Date: Tue, 01 Mar 2011 14:48:45 -0800
Subject: [GIT PULL] omap fixes for v2.6.38-rc6
In-Reply-To: <alpine.DEB.1.10.1103011931380.27610@esdhcp041196.research.nokia.com>
	(Aaro Koskinen's message of "Tue, 1 Mar 2011 19:39:01 +0200 (EET)")
References: <20110228194151.GJ20560@atomide.com>
	<alpine.DEB.1.10.1103011931380.27610@esdhcp041196.research.nokia.com>
Message-ID: <87aahefodu.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Hi,
>
> On Mon, 28 Feb 2011, Tony Lindgren wrote:
>> Please pull omap fixes from:
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus
>>
>> This contains one more timer regression fix, a DPLL rate fix,
>> and a mailbox NULL pointer fix that would be good to get
>> in for 2.6.38. The series also removes world-writable flag for
>> some debugfs entries.
>>
>> Other than I believe that's it for omap fixes for v2.6.38.
>
> I wonder what happened to this patch:
>
> 	http://marc.info/?l=linux-omap&m=129772313519005&w=2
>

I have it queued with some other PM fixes that I haven't (yet) pushed to
Tony due to being on vacation.

Will take care of that today or tomorrow at the latest.

Kevin
