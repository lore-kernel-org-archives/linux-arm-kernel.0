From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 Feb 2013 13:20:25 +0530
Subject: [PATCH 1/2] cpustat: use accessor functions for get/set/add
In-Reply-To: <CAP245DVYsjgvww-3qBnbZ4T7SsJ=whbVvhf06fArxcspyX9bwQ@mail.gmail.com>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361512604-2720-2-git-send-email-khilman@linaro.org>
 <CAOh2x=kFL5_H=LqLf14yxYQEs7zSTT8Ue8mjUEVN4_a0c53Rdg@mail.gmail.com>
 <CAP245DVYsjgvww-3qBnbZ4T7SsJ=whbVvhf06fArxcspyX9bwQ@mail.gmail.com>
Message-ID: <CAKohpomx8B+=XhC=WFo0ZtEMM-DuBfwyMSKE4-Ng=5gyGGCxWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 February 2013 12:47, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> On Fri, Feb 22, 2013 at 11:51 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> BTW, i don't see kcpustat_cpu() used in
>>
>>  kernel/sched/core.c                | 12 +++++-------
>>  kernel/sched/cputime.c             | 29 +++++++++++++--------------
>>
>> I searched tip/master as well as lnext/master.
>
> Added by Frederic's Adaptive NOHZ patchset?

I don't even see them on our unused-nohz-adaptive-tickless-v2 branch :)
Maybe some other latest work.
