From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 13:39:31 -0600
Subject: [PATCH V5 0/9] ARM: tegra: add platform suspend support
In-Reply-To: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
Message-ID: <515B33F3.1010007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:20 AM, Joseph Lo wrote:
> This series introduces a basic functionality for Tegra to support the
> platform suspend and resume.
> 
> Note: This series only adds the support for Tegra20 and Tegra30. The
> Tegra114 will be supported later.
> 
> Verified on Seaboard and Cardhu.

I've also reproduced this on those two boards:-)

It's a pity that the only way to wake up Cardhu is using the RTC's
wakealarm though. Still, we can add extra keyboard/GPIO keys/... to the
various board DTs after this basic support series is checked in.
