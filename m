From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 21 Nov 2013 15:53:57 -0800
Subject: [PATCH 00/17] Convert ARM sched_clock users to
 sched_clock_register()
In-Reply-To: <528E955C.7090205@codeaurora.org> (Stephen Boyd's message of
 "Thu, 21 Nov 2013 15:21:00 -0800")
References: <1384557985-9414-1-git-send-email-sboyd@codeaurora.org>
 <87li0h8i70.fsf@linaro.org> <528E955C.7090205@codeaurora.org>
Message-ID: <87a9gx8g6i.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd <sboyd@codeaurora.org> writes:

> On 11/21/13 15:10, Kevin Hilman wrote:
>> Hi Stephen,
>>
>> Stephen Boyd <sboyd@codeaurora.org> writes:
>>
>>> Olof,
>>>
>>> Please consider picking up these simple conversion patches. They
>>> were sent a few months back[1] but I didn't keep pushing them due
>>> to the complex path to mainline that the core patches took. I've
>>> picked up the acks and resent. Now that the core kernel changes have
>>> landed in Linus' tree it's much easier to pull these changes in.
>> Just to clarify, are the dependencies in v3.12? or were they merged for
>> the v3.13 merge window and just recently it Linus' tree.
>
> The dependencies are not in 3.12. They just hit Linus' tree this merge
> window (3.13). Ingo brought it into tip at commit
> 68e90740284c69292881cd38c7ece6f09a18a58f and Linus took it at commit
> 87093826aa0172d9135ca1f301c4298a258ceee6.

OK, thanks for the clarification.

I've applied these to an soc/sched_clock branch which is based on
tip/timers-core-for-linus and merged it into our to-build branch so it
gets some early boot/build coverage.  Once -rc1 is out, we'll start
adding non-fixes to for-next and this will be among the first branches
there (assuming the build/boot doesn't show any problems.)

Kevin
