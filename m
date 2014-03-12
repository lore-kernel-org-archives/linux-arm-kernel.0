From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 12 Mar 2014 17:19:56 +0000
Subject: [PATCH] arm64: Fix duplicated Kconfig entries
In-Reply-To: <531F16C6.5030903@arm.com>
References: <1394543851-11732-1-git-send-email-broonie@kernel.org>
 <531F16C6.5030903@arm.com>
Message-ID: <20140312171955.GR17083@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 01:59:34PM +0000, Sudeep Holla wrote:
> On 11/03/14 13:17, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>
> >
> > Probably due to rebasing over the lengthy time it took to get the patch
> > merged commit addea9ef055b (cpufreq: enable ARM drivers on arm64) added
> > a duplicate Power management options section.  Add CPUfreq to the CPU
> > power management section and remove a duplicate include of the main
> > power section.
> 
> This looks fine to me, but since commit addea9ef055b is only in Rafael's
> next tree, Catalin can't take this, so it makes sense to go through Rafael's
> tree, right ?

I actually took this patch and noticed that Rafael took it as well. The
above commit I think is only valid in the arm64 tree for -next.

-- 
Catalin
