From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 26 Jun 2013 19:11:21 +0800
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <51C9B36A.3040808@wwwdotorg.org>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
 <51C9B36A.3040808@wwwdotorg.org>
Message-ID: <1372245081.2986.20.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-06-25 at 23:12 +0800, Stephen Warren wrote:
> On 06/25/2013 03:23 AM, Joseph Lo wrote:
> > Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> > to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> > this state.
> 
> I assume this patch is only needed to support the other two series you
> sent today; the Tegra114 cpuidle and system suspend series? In other
> words, there's no need to apply this to 3.11 to fix a bug; it can wait
> for 3.12 along with those other two series?

This patch is independent of the other two series, you can apply it
along.
Yes, all these series were for 3.12.

Thanks,
Joseph
