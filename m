From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Jul 2013 18:43:28 -0700
Subject: [PATCH RFC 3/3] cpufreq: cpufreq-cpu0: clk rate-change notifiers
In-Reply-To: <CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
References: <1373247868-21444-1-git-send-email-mturquette@linaro.org>
 <1373247868-21444-4-git-send-email-mturquette@linaro.org>
 <CAOh2x=kAM98Qta5RquVVByR8jJ3=t+6fNZ4o4WSroVCCZi+0Cg@mail.gmail.com>
Message-ID: <20130731014328.5270.4248@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Viresh Kumar (2013-07-07 21:10:54)
> On Mon, Jul 8, 2013 at 7:14 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > Removes direct handling of OPP tables and voltage regulators by calling
> > of_clk_cpufreq_notifier_handler, introduced by commit "clk: cpufreq
> > helper for voltage scaling".
> >
> > In the future this can help consolidate code found across similar
> > CPUfreq drivers.
> >
> > Signed-off-by: Mike Turquette <mturquette@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq-cpu0.c | 125 ++++++++---------------------------------
> >  1 file changed, 22 insertions(+), 103 deletions(-)
> 
> Good patch, really gets lots of stuff out from cpufreq drivers.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Viresh,

Thanks for the Ack. I received no comments on this series besides your
own, so I plan to merge it. Do you want to take patch #3, or do you want
me to take it, or should I give you and Rafael a stable branch instead?

Regards,
Mike
