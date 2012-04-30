From: khilman@ti.com (Kevin Hilman)
Date: Mon, 30 Apr 2012 15:58:19 -0700
Subject: [PATCH 00/18][V3] ARM: OMAP3/4 : cpuidle34xx and cpuidle44xx
 cleanups
In-Reply-To: <4F98740F.1020402@linaro.org> (Daniel Lezcano's message of "Thu,
 26 Apr 2012 00:00:47 +0200")
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
 <4F98740F.1020402@linaro.org>
Message-ID: <87vckgltdg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 04/24/2012 04:05 PM, Daniel Lezcano wrote:
>> This patchset makes some cleanup on these cpuidle drivers
>> and consolidate the code across both architecture.
>>
>> Tested on OMAP3 (igepV2).
>> Partially tested on OMAP4 (pandaboard), without offlining the cpu1.

Without offlining CPU1, none of this code is executed.  Can you test
with CPU1 offlined?

> Hi,
>
> could be this patchset considered for inclusion ?
>

Yes.   This is a good series, and a great cleanup.

Unfortunately, there is lots of OMAP PM code to review at the moment so
there's a bit of a lag in my ability to review and test.

Tested-by tags from others on various platforms will also go a long ways
as well.

Kevin
