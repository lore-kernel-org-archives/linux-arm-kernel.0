From: davej@redhat.com (Dave Jones)
Date: Wed, 14 Mar 2012 14:40:53 -0400
Subject: [PATCH v2 RE-SEND] [CPUFREQ] EXYNOS5250: Add support cpufreq for
 EXYNOS5250
In-Reply-To: <4F60E25C.9060005@samsung.com>
References: <1331377202-25173-1-git-send-email-kgene.kim@samsung.com>
 <4F60D5FE.7080400@samsung.com> <20120314175703.GA3803@redhat.com>
 <4F60E25C.9060005@samsung.com>
Message-ID: <20120314184053.GC3803@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 11:24:28AM -0700, Kukjin Kim wrote:
 > 2012-03-14 ?? 10:57, Dave Jones ? ?:
 > > On Wed, Mar 14, 2012 at 10:31:42AM -0700, Kukjin Kim wrote:
 > >   >  Kukjin Kim wrote:
 > >   >  >  From: Jaecheol Lee<jc.lee@samsung.com>
 > >   >  >
 > >   >  >  This patch adds support cpufreq for EXYNOS5250 SoC. Basically,
 > >   >  >  the exynos-cpufreq.c is used commonly and exynos5250-cpufreq.c
 > >   >  >  is used for EXYNOS5250(two Cortex-A15 cores) SoC.
 > >   >  >
 > >   >  >  Signed-off-by: Jaecheol Lee<jc.lee@samsung.com>
 > >   >  >  Signed-off-by: Kukjin Kim<kgene.kim@samsung.com>
 > >   >
 > >   >  Hi again Dave :)
 > >   >
 > >   >  Please pick up this patch for v3.4.
 > >   >  If any problems, please kindly let us know.
 > >
 > > this, and the other patch doesn't apply against current cpufreq.git
 > >
 > Oops, maybe you applied this first. Pleae try again EXYNOS4X12 first 
 > then, this. I applied on top of cpufreq/next and there was no complain.
 > 
 > If any problems, please kindly let me know.

Applied and pushed. thanks!

	Dave
 
