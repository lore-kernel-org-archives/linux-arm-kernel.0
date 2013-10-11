From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 11 Oct 2013 09:59:36 -0600
Subject: [PATCH] ARM: tegra: enable Tegra RTC as default for Tegra124
In-Reply-To: <1381485425-3354-1-git-send-email-josephl@nvidia.com>
References: <1381485425-3354-1-git-send-email-josephl@nvidia.com>
Message-ID: <52582068.5060809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2013 03:57 AM, Joseph Lo wrote:
> This patch makes the Tegra RTC enabled as default for Tegra124 platform.

I've applied this to Tegra's for-3.13/dt branch.

> Note:
> This patch was based on the patch "ARM: tegra: add clock properties for
> devices of Tegra124" that already queued in linux-tegra.

That patch has been posted, but not queued. I can't queue it until
Peter's clock series is finalized, since it depends on that.
