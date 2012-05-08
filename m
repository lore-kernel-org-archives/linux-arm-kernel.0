From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 08 May 2012 15:16:27 +0900
Subject: CPUFREQ maintainence.
In-Reply-To: <20120430140645.GB12583@redhat.com>
References: <20120430140645.GB12583@redhat.com>
Message-ID: <018601cd2ce2$19fdd8f0$4df98ad0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Jones wrote:
> 
> This last few releases I've been more of a hindrance than help to getting
> some of the patches merged upstream, so due to my lack of time, I'm
> considering
> removing myself as maintainer, and having patches routed as such
instead...
> 
> ARM -> Russell/relevant ARM subtree maintainers
> x86 driver patches -> x86 at vger.kernel.org
> (All the other archs currently supported already go through the arch trees
> mips/sparc etc)
> 
> The core doesn't see a huge amount of change these days, I figure patches
> for
> that can just go to lkml & Linus/Andrew like any other subsystem.
> 
> comments?
> 
The most EXYNOS SoCs' cpufreq drivers have been updated by Jaecheol Lee and
it is still needed to update/upgrade. I think, Mr. Lee can maintain
drivers/cpufreq/exynos* and he is a right person for it.

Russell, Dave, how do you think?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
