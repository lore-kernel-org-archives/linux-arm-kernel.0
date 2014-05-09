From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 9 May 2014 14:55:08 +0530
Subject: [PATCH] ARM: Don't ever downscale loops_per_jiffy in SMP systems
In-Reply-To: <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
References: <1399504982-31181-1-git-send-email-dianders@chromium.org>
 <CAOh2x=kwaoSdj8JO0Vo08Y0dX2UfKFiF3pBV-qtp-YTyN=8H8Q@mail.gmail.com>
 <CAD=FV=UEGJGHrdcXgs3EZ_wFXT8GnNeCOMt7CgdiiUzBzZ5Y0A@mail.gmail.com>
Message-ID: <CAKohpo=fCKXmvM1PA6ob2Aai+C94RQfEiLMPp9s6stPuQw7aWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 May 2014 20:55, Doug Anderson <dianders@chromium.org> wrote:
> On Thu, May 8, 2014 at 3:41 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> And if that's the case, why don't we get rid of it completely and set
>> global-loop-per-jiffy for the max freq at boot ?
>
> How exactly do you do this in a generic way?

We could have requested for the highest possible frequency value
from cpufreq and adjust accordingly at boot.

But probably thread is turning in another direction now, so lets wait
to see what others have in box.
