From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Sat, 08 Aug 2015 00:24:36 +0200
Subject: [PATCH v4 0/6] cpufreq: use generic cpufreq drivers for
 Exynos4x12 platform
In-Reply-To: <20150807115627.GH6939@linux>
References: <1438868514-8814-1-git-send-email-b.zolnierkie@samsung.com>
 <2359635.Hxe4cb8zKm@amdc1976> <20150807115627.GH6939@linux>
Message-ID: <1525406.7aXvVQzEDd@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, August 07, 2015 05:26:27 PM Viresh Kumar wrote:
> On 07-08-15, 13:47, Bartlomiej Zolnierkiewicz wrote:
> > Hmm, wait.  Patch 6/6 depends on earlier changes.  I cannot remove
> > the config option in question now as it is currently used by
> > exynos-cpufreq specific boost support.  Patch 1/6 can be applied
> > now but 6/6 needs to wait for patches 2-5 to be applied first.
> > 
> > Actually 6/6 is trivial and can be applied later in v4.3 cycle or
> > even in v4.4 one.
> 
> Ack.

OK, so please let me know which patches you want me to pick up.

Ideally, I'd prefer them to be resent in a separate series with ACKs and all
with a cover letter clearly stating whose tree they are being targeted at.

Thanks,
Rafael
