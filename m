From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 01 Mar 2014 00:26:23 +0100
Subject: [PATCH v3 1/3] cpufreq: stats: Remove redundant cpufreq_cpu_get()
 call
In-Reply-To: <CAKohpomjtE7Rtrs-TgxtSo658+4p0AHLzr9niN1GnkkrDqTxTw@mail.gmail.com>
References: <1393552716-9754-1-git-send-email-skannan@codeaurora.org>
 <CAKohpomjtE7Rtrs-TgxtSo658+4p0AHLzr9niN1GnkkrDqTxTw@mail.gmail.com>
Message-ID: <8945263.cDODqBSQxb@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, February 28, 2014 09:18:02 AM Viresh Kumar wrote:
> On 28 February 2014 07:28, Saravana Kannan <skannan@codeaurora.org> wrote:
> > __cpufreq_stats_create_table always gets pass the valid and real policy
> > struct. So, there's no need to call cpufreq_cpu_get() to get the policy
> > again.
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> All patches look fine now. Rafael you can queue them up as per your
> convenience.
> 
> @Saravana: Though I am quite sure you still need my patches to get
> your initial issue fixed. So, can you please get them tested as early
> as possible, so that we can get them in for 3.14?

That's a bit late ...

> @Srivatsa: Your reviews will also help :)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
