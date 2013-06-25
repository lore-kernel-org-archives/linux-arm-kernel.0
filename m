From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Jun 2013 09:12:42 -0600
Subject: [PATCH] ARM: tegra: cpuidle: use CPUIDLE_FLAG_TIMER_STOP flag
In-Reply-To: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
References: <1372152228-16199-1-git-send-email-josephl@nvidia.com>
Message-ID: <51C9B36A.3040808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2013 03:23 AM, Joseph Lo wrote:
> Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
> to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
> this state.

I assume this patch is only needed to support the other two series you
sent today; the Tegra114 cpuidle and system suspend series? In other
words, there's no need to apply this to 3.11 to fix a bug; it can wait
for 3.12 along with those other two series?
