From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 02 Mar 2018 10:32:25 +0000
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
Message-ID: <86po4m3gzq.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Mar 2018 09:14:50 +0000,
Alex Shi wrote:
> 
> 
> 
> On 03/01/2018 11:24 PM, Greg KH wrote:
> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
> >> Hi All,
> >>
> >> This backport patchset fixed the meltdown issue, it's original branch:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> >> A few dependency or fixingpatches are also picked up, if they are necessary
> >>  and no functional changes.
> >>
> >> The patchset also on repository:
> >> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 
> >>
> >> No bug found yet from kernelci.org and lkft testing.
> > 
> > No bugs is good, but does it actually fix the meltdown problem?  What
> > did you test it on?
> 
> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.

Cortex-A73 is not affected by Meltdown. Only A75 is. Please don't
spread misinformation. They are both affected by Spectre though.

	M.

-- 
Jazz is not dead, it just smell funny.
