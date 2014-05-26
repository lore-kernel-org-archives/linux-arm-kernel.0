From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 May 2014 10:37:50 +0900
Subject: [PATCH v5 0/7] cpufreq: use cpufreq-cpu0 driver for exynos based
 platforms
In-Reply-To: <538294F9.2060508@gmail.com>
References: <1400855260-6807-1-git-send-email-thomas.ab@samsung.com>
 <5382739A.60800@samsung.com> <538294F9.2060508@gmail.com>
Message-ID: <032801cf7883$1cde3fd0$569abf70$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Kukjin,
> 
Hi,

> On 26.05.2014 00:50, Kukjin Kim wrote:
> > On 05/23/14 23:27, Thomas Abraham wrote:
> >> Changes since v4:
> >> - Various changes in clock code suggested by Tomasz
> >> Figa<t.figa@samsung.com>
> >> - This series depends on mutiple other patches
> >>    [a] patch that introduces read-only attribute for clock dividers.
> >>        -
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-
> May/259264.html
> >>
> >>    [b] the series "PM / OPP: move cpufreq specific helpers out of OPP
> >> layer"
> >>        -
> >> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg104610.html
> >>    [c] the series "cpufreq: opp: Add device tree based lookup of boost
> >> mode frequency"
> >>        - http://www.spinics.net/lists/arm-kernel/msg334336.html
> >>
> > This series looks good to me after quick loking at but as I replied on
> > other thread, I'm not sure above changes are ready for 3.16 or not...
> >
> > Maybe we can revisit this series for 3.17?...hmm...
> 
> Also two more issues:
> 
> 1) DT bindings are not acked by DT maintainers,
> 2) there are my comments to DT bindings from v4 not addressed.
> 
> There are also several comments about the code of v4 not addressed, but
> this is not that important, as opposed to DT bindings which are supposed
> to be stable ABI.
> 
> Still, I don't think this is a big deal anymore, as we can have cpufreq
> working with multiplatform with my hack patch and polish the
> implementation of this series without any hurry.
> 
Yeah, I'm waiting for Viresh's ack on your v2 exynos-cpufreq changes for
multiplatform...

- Kukjin
