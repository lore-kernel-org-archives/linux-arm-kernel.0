From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Apr 2013 16:53:34 -0600
Subject: [PATCH] ARM: tegra: pm: fix build error w/o PM_SLEEP
In-Reply-To: <1365730733-22701-1-git-send-email-josephl@nvidia.com>
References: <1365730733-22701-1-git-send-email-josephl@nvidia.com>
Message-ID: <516C84EE.8010204@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2013 07:38 PM, Joseph Lo wrote:
> This fixes the building error when the PM_SLEEP is disabled. The fucntional
> defintion of "tegra_pm_validate_suspend_mode" without "static inline"
> would become a multiple definition error.

Thanks. I have forwarded this to arm-soc to be applied.
