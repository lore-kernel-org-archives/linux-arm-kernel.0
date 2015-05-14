From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 14 May 2015 22:15:40 +0200
Subject: [PATCH v9 00/17] Tegra124 CL-DVFS / DFLL clocksource + cpufreq
In-Reply-To: <55543D6F.2040704@kapsi.fi>
References: <1431529131-16710-1-git-send-email-mikko.perttunen@kapsi.fi>
 <2216026.DiZ8MPKfdF@vostro.rjw.lan> <55543D6F.2040704@kapsi.fi>
Message-ID: <3099473.H5qjMpDQKF@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, May 14, 2015 09:15:11 AM Mikko Perttunen wrote:
> On 05/14/2015 01:47 AM, Rafael J. Wysocki wrote:
>  > ...
> >
> > If I'm supposed to apply this, I need ACKs from the appropriate people on
> > all the patches where they are still missing.  Thanks!
> >
> >
> 
> I believe Thierry Reding will apply the series; your ACK as cpufreq 
> maintainer for patch 13, and maybe also 12, would be welcome, though :)
> 
> Patch 13 just renames the old tegra-cpufreq driver that only applies to 
> Tegra20 chips to tegra20-cpufreq.
> 
> Patch 12 adds device tree bindings. Maybe these can also be acked by 
> Thierry? I'm not completely sure what's the convention.

You need ACKs from Viresh for those two, then.  He's officially responsible
for ARM cpufreq drivers.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
