From: amit.kucheria@linaro.org (Amit Kucheria)
Date: Wed, 11 Sep 2013 16:23:45 +0530
Subject: [PATCH 0/5] CPUFreq: Last set of updates for 3.13
In-Reply-To: <cover.1378893296.git.viresh.kumar@linaro.org>
References: <cover.1378893296.git.viresh.kumar@linaro.org>
Message-ID: <CAP245DXeU39UE5-_G3J=r=arPt-8DieL4uN9SOOvWQf5xS3wAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 3:43 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Rafael,
>
> I really tried to stop after you asked me to, but still got few more patches..
> These are very minor changes and a fairly smaller patchset..
>
> I have rebased this over your linux-next branch
>
> 7c218b1 Merge branch 'acpi-bind-next' into linux-next
>
> and tested over my exynos board.. I don't expect them to do any crappy stuff..
>
> You can include these first (if they look fine) and then I will send all other
> patches that I have queued up for 3.13.. I will send all of them in one lot,
> with partition numbers mentioned (i.e. patches that should go together) and then
> you can apply them the way you wish.. Set by set or all at once..
>
> Thanks..

Viresh,

Thanks for the great work cleaning up all the drivers. IIUC, you have
~200 patches lined up for the 3.13 merge window. That causes some
worries.

Can we quickly do the following to get more confidence that there
won't be wide-spread breakage:

1. Get all of these into linux-next quickly
2. Set up a LAVA[1] job to get linux-next kernels running on boards in our farm
3. Run cpufreq functional tests, e.g. PM-QA[2] test suite from Linaro
with these kernels

Regards,
Amit
[1] An automated test harness used by Linaro
[2] https://git.linaro.org/gitweb?p=tools/pm-qa.git;a=tree;f=cpufreq;h=b53f7ad0fe778011d75e94ec7bd2b2fc1fc4cfd7;hb=HEAD
