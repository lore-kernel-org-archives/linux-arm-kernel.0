From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 21 Apr 2016 02:41:24 +0200
Subject: [RESEND][PATCH 1/3] thermal: mediatek: Add cpu dynamic power
 cooling model.
In-Reply-To: <57176ECF.6020705@gmail.com>
References: <1458029437-12846-1-git-send-email-dawei.chien@mediatek.com>
 <CAJZ5v0hpkyMCVhvYy4JzR1A5OZKs7dqDOB64aQXmjXiLM0F=BQ@mail.gmail.com>
 <57176ECF.6020705@gmail.com>
Message-ID: <12007858.UuqVGafLHV@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 20, 2016 01:58:07 PM Matthias Brugger wrote:
> Hi Rafael,
> 
> On 13/04/16 06:52, Rafael J. Wysocki wrote:
> > On Tue, Apr 12, 2016 at 7:38 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >> Hi Rafael,
> >>
> >> On 15-03-16, 16:10, Dawei Chien wrote:
> >>> MT8173 cpufreq driver select of_cpufreq_power_cooling_register registering
> >>> cooling devices with dynamic power coefficient.
> >>>
> >>> Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
> >>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>
> >> Can you please apply this patch from Dawei ?
> >
> > I can, but I'm traveling this week, so that's rather going to happen next week.
> >
> 
> I don't see the patch in linux-next, did you forget to pick/push it?

No, I didn't.  I just didn't have the time to get to them before.

Now, given that they are thermal patches, they really should go in via
linux-soc-thermal.git.

Eduardo, any chance to take care of these?

Thanks,
Rafael
