From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 03 Aug 2015 12:47:57 +0200
Subject: [PATCH v3 3/5] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4x12
In-Reply-To: <20150803104044.GB21529@linux>
References: <1438368557-2352-1-git-send-email-b.zolnierkie@samsung.com>
 <4532306.AVvo5hem3c@amdc1976> <20150803104044.GB21529@linux>
Message-ID: <2295533.OBI6Q4a3b9@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 03, 2015 04:10:44 PM Viresh Kumar wrote:
> On 03-08-15, 12:36, Bartlomiej Zolnierkiewicz wrote:
> > I would really like it to be dependency not an option (+ I think
> > that ideally it should be checked at runtime, IOW we should be
> > checking from cpufreq-dt driver if the thermal support is enabled
> > before enabling boost support).
> 
> I don't think boost has any dependency on thermal support. Yeah, it
> may be true for your platform but we can't force it. People might have
> different algorithms to control boost modes, thermal is just one
> option they may look at. For few, enabling boost may not be a thermal
> issue, but power. So, they want to allow it only when they want, but
> that wouldn't burn their chip.

OK, I see your point (I have not thought about power being the boost
limitation previously).

> So, a platform can choose how it wants to have it. :)

I'll re-do this patch.  Thank you.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
